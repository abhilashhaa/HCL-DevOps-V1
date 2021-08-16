  METHOD check_in_check_table.

*    TYPES:
*      BEGIN OF lty_where_condition,
*        condition(72) TYPE c,
*      END OF lty_where_condition.

    TYPES: lty_where_condition TYPE c LENGTH 72.

    DATA:
      BEGIN OF ls_conversion,
        filler1(16) TYPE c VALUE 'CONVERSION_EXIT_',
        convexit    TYPE convexit,
        filler2(6)  TYPE c VALUE '_INPUT',
      END OF ls_conversion,

      lv_exists           TYPE abap_bool,
      lt_where_conditions TYPE TABLE OF lty_where_condition,
      ls_where_condition  TYPE lty_where_condition.

    FIELD-SYMBOLS: <lv_value> TYPE any.

    CHECK iv_charcvalue IS NOT INITIAL.

    ev_new_charcvalue   = iv_charcvalue.
    DATA(lv_charcvalue) = iv_charcvalue.

    mo_chr_util_chcktable->get_key_field(
      EXPORTING
        iv_check_table_name = iv_check_table_name
      IMPORTING
        ev_key_field_name   = DATA(lv_key_field_name)
        ev_conversion_exit  = DATA(lv_conversion_exit)
        ev_length           = DATA(lv_key_length) ).

    IF lv_conversion_exit IS NOT INITIAL.
      ls_conversion-convexit = lv_conversion_exit.

      CONDENSE ls_conversion NO-GAPS.
      DESCRIBE FIELD lv_charcvalue LENGTH DATA(lv_length_char) IN CHARACTER MODE.

      IF lv_key_length > lv_length_char.
        lv_key_length = lv_length_char.
      ENDIF.

      ASSIGN lv_charcvalue(lv_key_length) TO <lv_value>.
      IF lv_charcvalue <> <lv_value>.
        RAISE value_not_found.
      ENDIF.

      CALL FUNCTION ls_conversion
        EXPORTING
          input  = lv_charcvalue
        IMPORTING
          output = <lv_value>
        EXCEPTIONS
          OTHERS = 1.

      IF sy-subrc <> 0.
        RAISE value_not_found.
      ENDIF.

      ev_new_charcvalue = <lv_value>.
    ENDIF.

    " Convert single quotes into double quotes
    lv_charcvalue = cl_abap_dyn_prg=>escape_quotes( lv_charcvalue ).

    CONCATENATE lv_key_field_name ' EQ '' ' lv_charcvalue '''' INTO ls_where_condition.
    APPEND ls_where_condition TO lt_where_conditions.

    TEST-SEAM select_dynamic.
      TRY.
        SELECT SINGLE @abap_true FROM (iv_check_table_name)
          INTO @lv_exists
          WHERE (lt_where_conditions).

        CATCH cx_sy_dynamic_osql_semantics.
          " Pool tables and cluster tables doesn't support new SQL syntax
          SELECT COUNT(*) FROM (iv_check_table_name)
            UP TO 1 ROWS
            WHERE (lt_where_conditions).
      ENDTRY.
    END-TEST-SEAM.

    IF sy-subrc IS NOT INITIAL.
      RAISE value_not_found.
    ENDIF.

    IF lv_conversion_exit IS NOT INITIAL.
      convert_internal_to_external(
        EXPORTING
          iv_convexit       = lv_conversion_exit
          is_characteristic = is_characteristic
          iv_assigned_value = ev_new_charcvalue
          iv_class_type     = iv_classtype
        IMPORTING
          ev_new_value      = ev_new_charcvalue ).
    ENDIF.

  ENDMETHOD.