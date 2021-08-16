  METHOD zif_abapgit_ajson_reader~get_boolean.

    DATA lv_item TYPE REF TO ty_node.
    lv_item = get_item( iv_path ).
    IF lv_item IS INITIAL OR lv_item->type = 'null'.
      RETURN.
    ELSEIF lv_item->type = 'bool'.
      rv_value = boolc( lv_item->value = 'true' ).
    ELSEIF lv_item->value IS NOT INITIAL.
      rv_value = abap_true.
    ENDIF.

  ENDMETHOD.