  METHOD zif_abapgit_ajson_reader~get_date.

    DATA lv_item TYPE REF TO ty_node.
    DATA lv_y TYPE c LENGTH 4.
    DATA lv_m TYPE c LENGTH 2.
    DATA lv_d TYPE c LENGTH 2.

    lv_item = get_item( iv_path ).

    IF lv_item IS NOT INITIAL AND lv_item->type = 'str'.
      FIND FIRST OCCURRENCE OF REGEX '^(\d{4})-(\d{2})-(\d{2})(T|$)'
        IN lv_item->value
        SUBMATCHES lv_y lv_m lv_d.
      CONCATENATE lv_y lv_m lv_d INTO rv_value.
    ENDIF.

  ENDMETHOD.