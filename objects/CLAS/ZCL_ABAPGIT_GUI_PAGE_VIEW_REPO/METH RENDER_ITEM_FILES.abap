  METHOD render_item_files.

    DATA: ls_file LIKE LINE OF is_item-files.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF mv_hide_files = abap_true AND is_item-obj_type IS NOT INITIAL.
      RETURN.
    ENDIF.

    LOOP AT is_item-files INTO ls_file.
      ri_html->add( |<div>{ ls_file-path && ls_file-filename }</div>| ).
    ENDLOOP.

  ENDMETHOD.