  METHOD render_item.

    DATA: lv_link    TYPE string,
          lv_colspan TYPE i.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF iv_render_transports = abap_false.
      lv_colspan = 2.
    ELSE.
      lv_colspan = 3.
    ENDIF.

    ri_html->add( |<tr{ get_item_class( is_item ) }>| ).

    IF is_item-obj_name IS INITIAL AND is_item-is_dir = abap_false.
      ri_html->add( |<td colspan="{ lv_colspan }"></td>|
                 && '<td class="object">'
                 && '<i class="grey">non-code and meta files</i>'
                 && '</td>' ).
    ELSE.
      ri_html->add( |<td class="icon">{ get_item_icon( is_item ) }</td>| ).
      IF iv_render_transports = abap_true.
        ri_html->add( render_item_lock_column( is_item ) ).
      ENDIF.

      IF is_item-is_dir = abap_true. " Subdir
        lv_link = build_dir_jump_link( is_item-path ).
        ri_html->add( |<td class="dir" colspan="2">{ lv_link }</td>| ).
      ELSE.
        lv_link = build_obj_jump_link( is_item ).
        ri_html->add( |<td class="type">{ is_item-obj_type }</td>| ).
        ri_html->add( |<td class="object">{ lv_link } { build_inactive_object_code( is_item ) }</td>| ).
      ENDIF.
    ENDIF.

    " Files
    ri_html->add( '<td class="files">' ).
    ri_html->add( render_item_files( is_item ) ).
    ri_html->add( '</td>' ).

    " Command
    IF mo_repo->has_remote_source( ) = abap_true.
      ri_html->add( '<td class="cmd">' ).
      ri_html->add( render_item_command( is_item ) ).
      ri_html->add( '</td>' ).
    ENDIF.

    ri_html->add( '</tr>' ).

  ENDMETHOD.