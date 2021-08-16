  METHOD get_item_icon.

    CASE is_item-obj_type.
      WHEN 'PROG' OR 'CLAS' OR 'FUGR' OR 'INTF' OR 'TYPE'.
        rv_html = zcl_abapgit_html=>icon( 'file-code/darkgrey' ).
      WHEN 'W3MI' OR 'W3HT' OR 'SFPF'.
        rv_html = zcl_abapgit_html=>icon( 'file-image/darkgrey' ).
      WHEN 'DEVC'.
        rv_html = zcl_abapgit_html=>icon( 'box/darkgrey' ).
      WHEN ''.
        rv_html = space. " no icon
      WHEN OTHERS.
        rv_html = zcl_abapgit_html=>icon( 'file-alt/darkgrey' ).
    ENDCASE.

    IF is_item-is_dir = abap_true.
      rv_html = zcl_abapgit_html=>icon( 'folder/darkgrey' ).
    ENDIF.

  ENDMETHOD.