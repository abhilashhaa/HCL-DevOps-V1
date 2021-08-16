  METHOD build_comment.

    DATA: lt_objects TYPE STANDARD TABLE OF string WITH DEFAULT KEY,
          lv_str     TYPE string.

    FIELD-SYMBOLS: <ls_local> LIKE LINE OF is_files-local.


    LOOP AT is_files-local ASSIGNING <ls_local>.
      lv_str = |{ <ls_local>-item-obj_type } { <ls_local>-item-obj_name }|.
      APPEND lv_str TO lt_objects.
    ENDLOOP.

    SORT lt_objects AS TEXT.
    DELETE ADJACENT DUPLICATES FROM lt_objects.

    IF lines( lt_objects ) = 1.
      rv_comment = |BG: { lv_str }|.
    ELSE.
      rv_comment = 'BG: Multiple objects'.
      LOOP AT lt_objects INTO lv_str.
        CONCATENATE rv_comment zif_abapgit_definitions=>c_newline lv_str INTO rv_comment.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.