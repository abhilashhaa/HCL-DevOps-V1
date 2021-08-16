  METHOD run_checks.

    DATA: lv_path         TYPE string,
          ls_item         TYPE zif_abapgit_definitions=>ty_item,
          ls_file         TYPE zif_abapgit_definitions=>ty_file_signature,
          lt_res_sort     LIKE it_results,
          lt_item_idx     LIKE it_results,
          lt_move_idx     LIKE it_results,
          lo_folder_logic TYPE REF TO zcl_abapgit_folder_logic.

    FIELD-SYMBOLS: <ls_res1> LIKE LINE OF it_results,
                   <ls_res2> LIKE LINE OF it_results.


    IF ii_log IS INITIAL.
* huh?
      RETURN.
    ENDIF.

    " Find all objects which were assigned to a different package
    LOOP AT it_results ASSIGNING <ls_res1>
      WHERE lstate = zif_abapgit_definitions=>c_state-added AND packmove = abap_true.
      READ TABLE lt_move_idx TRANSPORTING NO FIELDS
        WITH KEY obj_type = <ls_res1>-obj_type obj_name = <ls_res1>-obj_name
        BINARY SEARCH. " Sorted since it_result is sorted
      IF sy-subrc <> 0.
        ii_log->add( iv_msg  = |Changed package assignment for object { <ls_res1>-obj_type } { <ls_res1>-obj_name }|
                     iv_type = 'W'
                     iv_rc   = '5' ).
        APPEND INITIAL LINE TO lt_move_idx ASSIGNING <ls_res2>.
        <ls_res2>-obj_type = <ls_res1>-obj_type.
        <ls_res2>-obj_name = <ls_res1>-obj_name.
        <ls_res2>-path     = <ls_res1>-path.
      ENDIF.
    ENDLOOP.

    " Collect object indexe
    lt_res_sort = it_results.
    SORT lt_res_sort BY obj_type ASCENDING obj_name ASCENDING.

    LOOP AT it_results ASSIGNING <ls_res1> WHERE NOT obj_type IS INITIAL AND packmove = abap_false.
      IF NOT ( <ls_res1>-obj_type = ls_item-obj_type
          AND <ls_res1>-obj_name = ls_item-obj_name ).
        APPEND INITIAL LINE TO lt_item_idx ASSIGNING <ls_res2>.
        <ls_res2>-obj_type = <ls_res1>-obj_type.
        <ls_res2>-obj_name = <ls_res1>-obj_name.
        <ls_res2>-path     = <ls_res1>-path.
        MOVE-CORRESPONDING <ls_res1> TO ls_item.
      ENDIF.
    ENDLOOP.

    " Check files for one object is in the same folder
    LOOP AT it_results ASSIGNING <ls_res1>
      WHERE NOT obj_type IS INITIAL AND obj_type <> 'DEVC' AND packmove = abap_false.
      READ TABLE lt_item_idx ASSIGNING <ls_res2>
        WITH KEY obj_type = <ls_res1>-obj_type obj_name = <ls_res1>-obj_name
        BINARY SEARCH. " Sorted above

      IF sy-subrc <> 0 OR <ls_res1>-path <> <ls_res2>-path. " All paths are same
        ii_log->add( iv_msg = |Files for object { <ls_res1>-obj_type } {
                       <ls_res1>-obj_name } are not placed in the same folder|
                     iv_type = 'W'
                     iv_rc   = '1' ).
      ENDIF.
    ENDLOOP.

    " Check that objects are created in package corresponding to folder
    lo_folder_logic = zcl_abapgit_folder_logic=>get_instance( ).
    LOOP AT it_results ASSIGNING <ls_res1>
      WHERE NOT package IS INITIAL AND NOT path IS INITIAL AND packmove = abap_false.
      lv_path = lo_folder_logic->package_to_path(
        iv_top     = iv_top
        io_dot     = io_dot
        iv_package = <ls_res1>-package ).
      IF lv_path <> <ls_res1>-path.
        ii_log->add( iv_msg = |Package and path does not match for object, {
                       <ls_res1>-obj_type } { <ls_res1>-obj_name }|
                     iv_type = 'W'
                     iv_rc   = '2' ).
      ENDIF.
    ENDLOOP.

    " Check for multiple files with same filename
    SORT lt_res_sort BY filename ASCENDING.

    LOOP AT lt_res_sort ASSIGNING <ls_res1> WHERE obj_type <> 'DEVC' AND packmove = abap_false.
      IF <ls_res1>-filename IS NOT INITIAL AND <ls_res1>-filename = ls_file-filename.
        ii_log->add( iv_msg  = |Multiple files with same filename, { <ls_res1>-filename }|
                     iv_type = 'W'
                     iv_rc   = '3' ).
      ENDIF.

      IF <ls_res1>-filename IS INITIAL.
        ii_log->add( iv_msg  = |Filename is empty for object { <ls_res1>-obj_type } { <ls_res1>-obj_name }|
                     iv_type = 'W'
                     iv_rc   = '4' ).
      ENDIF.

      MOVE-CORRESPONDING <ls_res1> TO ls_file.
    ENDLOOP.

  ENDMETHOD.