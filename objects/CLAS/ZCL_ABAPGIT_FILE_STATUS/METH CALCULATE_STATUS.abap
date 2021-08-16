  METHOD calculate_status.

    DATA: lt_remote       LIKE it_remote,
          lt_items        TYPE zif_abapgit_definitions=>ty_items_tt,
          ls_item         LIKE LINE OF lt_items,
          lv_is_xml       TYPE abap_bool,
          lv_sub_fetched  TYPE abap_bool,
          lt_sub_packages TYPE zif_abapgit_sap_package=>ty_devclass_tt,
          lt_items_idx    TYPE zif_abapgit_definitions=>ty_items_ts,
          lt_state_idx    TYPE zif_abapgit_definitions=>ty_file_signatures_ts. " Sorted by path+filename

    FIELD-SYMBOLS: <ls_remote> LIKE LINE OF it_remote,
                   <ls_result> LIKE LINE OF rt_results,
                   <ls_local>  LIKE LINE OF it_local.


    lt_state_idx = it_cur_state. " Force sort it
    lt_remote    = it_remote.
    SORT lt_remote BY path filename.

    " Process local files and new local files
    LOOP AT it_local ASSIGNING <ls_local>.
      APPEND INITIAL LINE TO rt_results ASSIGNING <ls_result>.
      IF <ls_local>-item IS NOT INITIAL.
        APPEND <ls_local>-item TO lt_items. " Collect for item index
      ENDIF.

      READ TABLE lt_remote ASSIGNING <ls_remote>
        WITH KEY path = <ls_local>-file-path filename = <ls_local>-file-filename
        BINARY SEARCH.
      IF sy-subrc = 0.  " Exist local and remote
        <ls_result> = build_existing(
          is_local  = <ls_local>
          is_remote = <ls_remote>
          it_state  = lt_state_idx ).
        ASSERT <ls_remote>-sha1 IS NOT INITIAL.
        CLEAR <ls_remote>-sha1. " Mark as processed
      ELSE.             " Only L exists
        <ls_result> = build_new_local( <ls_local> ).
        " Check if same file exists in different location
        READ TABLE lt_remote ASSIGNING <ls_remote>
          WITH KEY filename = <ls_local>-file-filename.
        IF sy-subrc = 0 AND <ls_local>-file-sha1 = <ls_remote>-sha1.
          <ls_result>-packmove = abap_true.
        ENDIF.
      ENDIF.
      <ls_result>-inactive = <ls_local>-item-inactive.
    ENDLOOP.

    " Complete item index for unmarked remote files
    LOOP AT lt_remote ASSIGNING <ls_remote> WHERE sha1 IS NOT INITIAL.
      identify_object( EXPORTING iv_filename = <ls_remote>-filename
                                 iv_path     = <ls_remote>-path
                                 io_dot      = io_dot
                                 iv_devclass = iv_devclass
                       IMPORTING es_item     = ls_item
                                 ev_is_xml   = lv_is_xml ).

      CHECK lv_is_xml = abap_true. " Skip all but obj definitions

      ls_item-devclass = get_object_package(
        iv_object   = ls_item-obj_type
        iv_obj_name = ls_item-obj_name ).

      IF NOT ls_item-devclass IS INITIAL AND iv_devclass <> ls_item-devclass.
        IF lv_sub_fetched = abap_false.
          lt_sub_packages = zcl_abapgit_factory=>get_sap_package( iv_devclass )->list_subpackages( ).
          lv_sub_fetched = abap_true.
          SORT lt_sub_packages BY table_line. "Optimize Read Access
        ENDIF.
* make sure the package is under the repo main package
        READ TABLE lt_sub_packages TRANSPORTING NO FIELDS
          WITH KEY table_line = ls_item-devclass
          BINARY SEARCH.
        IF sy-subrc <> 0.
          CLEAR ls_item-devclass.
        ENDIF.
      ENDIF.

      APPEND ls_item TO lt_items.
    ENDLOOP.

    SORT lt_items DESCENDING. " Default key - type, name, pkg, inactive
    DELETE ADJACENT DUPLICATES FROM lt_items COMPARING obj_type obj_name devclass.
    lt_items_idx = lt_items. " Self protection + UNIQUE records assertion

    " Process new remote files (marked above with empty SHA1)
    LOOP AT lt_remote ASSIGNING <ls_remote> WHERE sha1 IS NOT INITIAL.
      APPEND INITIAL LINE TO rt_results ASSIGNING <ls_result>.
      <ls_result> = build_new_remote( iv_devclass = iv_devclass
                                      io_dot      = io_dot
                                      is_remote   = <ls_remote>
                                      it_items    = lt_items_idx
                                      it_state    = lt_state_idx ).
      " Check if same file exists in different location
      READ TABLE it_local ASSIGNING <ls_local>
        WITH KEY file-filename = <ls_remote>-filename.
      IF sy-subrc = 0 AND <ls_local>-file-sha1 = <ls_remote>-sha1.
        <ls_result>-packmove = abap_true.
      ENDIF.
    ENDLOOP.

    SORT rt_results BY
      obj_type ASCENDING
      obj_name ASCENDING
      filename ASCENDING.

  ENDMETHOD.