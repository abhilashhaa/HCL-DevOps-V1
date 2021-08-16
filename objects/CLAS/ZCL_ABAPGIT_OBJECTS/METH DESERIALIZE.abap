  METHOD deserialize.

    DATA: ls_item     TYPE zif_abapgit_definitions=>ty_item,
          li_obj      TYPE REF TO zif_abapgit_object,
          lt_remote   TYPE zif_abapgit_definitions=>ty_files_tt,
          lv_package  TYPE devclass,
          lo_files    TYPE REF TO zcl_abapgit_objects_files,
          lo_xml      TYPE REF TO zif_abapgit_xml_input,
          lt_results  TYPE zif_abapgit_definitions=>ty_results_tt,
          li_progress TYPE REF TO zif_abapgit_progress,
          lv_path     TYPE string,
          lt_items    TYPE zif_abapgit_definitions=>ty_items_tt,
          lt_steps_id TYPE zif_abapgit_definitions=>ty_deserialization_step_tt,
          lt_steps    TYPE zif_abapgit_definitions=>ty_step_data_tt,
          lx_exc      TYPE REF TO zcx_abapgit_exception.
    DATA: lo_folder_logic TYPE REF TO zcl_abapgit_folder_logic.

    FIELD-SYMBOLS: <ls_result>  TYPE zif_abapgit_definitions=>ty_result,
                   <lv_step_id> TYPE LINE OF zif_abapgit_definitions=>ty_deserialization_step_tt,
                   <ls_step>    TYPE LINE OF zif_abapgit_definitions=>ty_step_data_tt,
                   <ls_deser>   TYPE LINE OF zif_abapgit_definitions=>ty_deserialization_tt.

    lt_steps = get_deserialize_steps( ).

    lv_package = io_repo->get_package( ).

    IF is_checks-transport-required = abap_true.
      zcl_abapgit_default_transport=>get_instance( )->set( is_checks-transport-transport ).
    ENDIF.

    zcl_abapgit_objects_activation=>clear( ).

    lt_remote = io_repo->get_files_remote( ).

    lt_results = files_to_deserialize( io_repo = io_repo
                                       ii_log = ii_log ).

    checks_adjust(
      EXPORTING
        io_repo    = io_repo
        is_checks  = is_checks
      CHANGING
        ct_results = lt_results ).

    li_progress = zcl_abapgit_progress=>get_instance( lines( lt_results ) ).

    lt_items = map_results_to_items( lt_results ).

    check_objects_locked( iv_language = io_repo->get_dot_abapgit( )->get_master_language( )
                          it_items    = lt_items ).

    lo_folder_logic = zcl_abapgit_folder_logic=>get_instance( ).
    LOOP AT lt_results ASSIGNING <ls_result>.
      li_progress->show( iv_current = sy-tabix
                         iv_text    = |Deserialize { <ls_result>-obj_name }| ).

      CLEAR ls_item.
      ls_item-obj_type = <ls_result>-obj_type.
      ls_item-obj_name = <ls_result>-obj_name.

      "error handling & logging added
      TRY.

          lv_package = lo_folder_logic->path_to_package(
            iv_top  = io_repo->get_package( )
            io_dot  = io_repo->get_dot_abapgit( )
            iv_path = <ls_result>-path ).

          IF ls_item-obj_type = 'DEVC'.
            " Packages have the same filename across different folders. The path needs to be supplied
            " to find the correct file.
            lv_path = <ls_result>-path.
          ENDIF.

          CREATE OBJECT lo_files
            EXPORTING
              is_item = ls_item
              iv_path = lv_path.
          lo_files->set_files( lt_remote ).

          "analyze XML in order to instantiate the proper serializer
          lo_xml = lo_files->read_xml( ).

          li_obj = create_object( is_item     = ls_item
                                  iv_language = io_repo->get_dot_abapgit( )->get_master_language( )
                                  is_metadata = lo_xml->get_metadata( ) ).

          compare_remote_to_local(
            ii_object = li_obj
            it_remote = lt_remote
            is_result = <ls_result>
            ii_log    = ii_log ).

          li_obj->mo_files = lo_files.

          "get required steps for deserialize the object
          lt_steps_id = li_obj->get_deserialize_steps( ).

          LOOP AT lt_steps_id ASSIGNING <lv_step_id>.
            READ TABLE lt_steps WITH KEY step_id = <lv_step_id> ASSIGNING <ls_step>.
            ASSERT sy-subrc = 0.
            IF <ls_step>-is_ddic = abap_true AND li_obj->get_metadata( )-ddic = abap_false.
              " DDIC only for DDIC objects
              zcx_abapgit_exception=>raise( |Step { <lv_step_id> } is only for DDIC objects| ).
            ENDIF.
            APPEND INITIAL LINE TO <ls_step>-objects ASSIGNING <ls_deser>.
            <ls_deser>-item    = ls_item.
            <ls_deser>-obj     = li_obj.
            <ls_deser>-xml     = lo_xml.
            <ls_deser>-package = lv_package.
          ENDLOOP.

          CLEAR: lv_path, lv_package.

        CATCH zcx_abapgit_exception INTO lx_exc.
          ii_log->add_exception( ix_exc = lx_exc
                                 is_item = ls_item ).
          ii_log->add_error( iv_msg = |Import of object { ls_item-obj_name } failed|
                             is_item = ls_item ).
          "object should not be part of any deserialization step
          CONTINUE.
      ENDTRY.

    ENDLOOP.

    "run deserialize for all steps and it's objects
    SORT lt_steps BY order.
    LOOP AT lt_steps ASSIGNING <ls_step>.
      deserialize_objects( EXPORTING is_step = <ls_step>
                                     ii_log  = ii_log
                           CHANGING ct_files = rt_accessed_files ).
    ENDLOOP.

    update_package_tree( io_repo->get_package( ) ).

    SORT rt_accessed_files BY path ASCENDING filename ASCENDING.
    DELETE ADJACENT DUPLICATES FROM rt_accessed_files. " Just in case

    zcl_abapgit_default_transport=>get_instance( )->reset( ).

  ENDMETHOD.