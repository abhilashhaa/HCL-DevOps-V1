  METHOD build_inactive_object_code.

    IF is_item-inactive = abap_true.
      rv_inactive_html_code = zcl_abapgit_html=>icon(
        iv_name  = 'bolt/orange'
        iv_hint  = 'Object or object part is inactive'
        iv_class = 'inactive' ).
    ENDIF.

  ENDMETHOD.