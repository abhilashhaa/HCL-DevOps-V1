  METHOD zif_abapgit_ajson_reader~get_string.

    DATA lv_item TYPE REF TO ty_node.
    lv_item = get_item( iv_path ).
    IF lv_item IS NOT INITIAL AND lv_item->type <> 'null'.
      rv_value = lv_item->value.
    ENDIF.

  ENDMETHOD.