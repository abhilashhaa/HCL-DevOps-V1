  METHOD deserialize_objects.

    DATA: li_progress TYPE REF TO zif_abapgit_progress,
          li_exit     TYPE REF TO zif_abapgit_exit,
          lx_exc      TYPE REF TO zcx_abapgit_exception.

    FIELD-SYMBOLS: <ls_obj> LIKE LINE OF is_step-objects.


    zcl_abapgit_objects_activation=>clear( ).

    li_progress = zcl_abapgit_progress=>get_instance( lines( is_step-objects ) ).

    LOOP AT is_step-objects ASSIGNING <ls_obj>.
      li_progress->show(
        iv_current = sy-tabix
        iv_text    = |Deserialize { is_step-descr } - { <ls_obj>-item-obj_name }| ).

      TRY.
          <ls_obj>-obj->deserialize( iv_package = <ls_obj>-package
                                     io_xml     = <ls_obj>-xml
                                     iv_step    = is_step-step_id
                                     ii_log     = ii_log ).
          APPEND LINES OF <ls_obj>-obj->mo_files->get_accessed_files( ) TO ct_files.

          ii_log->add_success( iv_msg = |Object { <ls_obj>-item-obj_name } imported|
                               is_item = <ls_obj>-item ).

        CATCH zcx_abapgit_exception INTO lx_exc.
          ii_log->add_exception( ix_exc = lx_exc
                                 is_item = <ls_obj>-item ).
          ii_log->add_error( iv_msg = |Import of object { <ls_obj>-item-obj_name } failed|
                             is_item = <ls_obj>-item ).
      ENDTRY.

    ENDLOOP.

    CASE is_step-step_id.
      WHEN zif_abapgit_object=>gc_step_id-ddic.
        zcl_abapgit_objects_activation=>activate( is_step-is_ddic ).
      WHEN zif_abapgit_object=>gc_step_id-abap.
        zcl_abapgit_objects_activation=>activate( is_step-is_ddic ).
      WHEN zif_abapgit_object=>gc_step_id-late.
        " late can have both DDIC (like TABL with REF TO) and non-DDIC objects
        zcl_abapgit_objects_activation=>activate( abap_true ).
        zcl_abapgit_objects_activation=>activate( abap_false ).
    ENDCASE.

*   Call postprocessing
    li_exit = zcl_abapgit_exit=>get_instance( ).

    li_exit->deserialize_postprocess( is_step = is_step
                                      ii_log  = ii_log ).

  ENDMETHOD.