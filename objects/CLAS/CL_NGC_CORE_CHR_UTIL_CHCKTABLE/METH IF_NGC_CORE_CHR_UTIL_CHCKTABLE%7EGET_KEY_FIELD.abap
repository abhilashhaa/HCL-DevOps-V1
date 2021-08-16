  METHOD if_ngc_core_chr_util_chcktable~get_key_field.

    DATA:
      lt_names   TYPE TABLE OF x031l,
      lv_package TYPE string.

    CLEAR: ev_key_field_name, ev_conversion_exit.

    READ TABLE mt_table_data
      ASSIGNING FIELD-SYMBOL(<ls_table_data>)
      WITH KEY
        check_table_name = iv_check_table_name.

    IF sy-subrc = 0.
      ev_key_field_name  = <ls_table_data>-key_field_name.
      ev_conversion_exit = <ls_table_data>-conversion_exit.
      ev_length          = <ls_table_data>-length.

      RETURN.
    ENDIF.

    DATA(lv_table_exists) = me->if_ngc_core_chr_util_chcktable~checktable_exsists( iv_check_table_name ).

    IF lv_table_exists = abap_false.
      RAISE table_not_found.
    ENDIF.

    me->if_ngc_core_chr_util_chcktable~get_table_details(
      EXPORTING
        iv_table_name = iv_check_table_name
      IMPORTING
        et_field_list = lt_names
      EXCEPTIONS
        not_found     = 1 ).

    IF sy-subrc NE 0.
      EXIT.
    ENDIF.

    LOOP AT lt_names ASSIGNING FIELD-SYMBOL(<ls_name>)
      WHERE dtyp <> 'CLNT'.
      ev_key_field_name  = <ls_name>-fieldname.
      ev_conversion_exit = <ls_name>-convexit.

      IF <ls_name>-exlength > <ls_name>-dblength.
        ev_length = <ls_name>-exlength.
      ELSE.
        ev_length = <ls_name>-dblength.
      ENDIF.

      EXIT.
    ENDLOOP.

    APPEND INITIAL LINE TO mt_table_data ASSIGNING <ls_table_data>.
    <ls_table_data>-check_table_name = iv_check_table_name.
    <ls_table_data>-key_field_name   = ev_key_field_name.
    <ls_table_data>-conversion_exit  = ev_conversion_exit.
    <ls_table_data>-length           = ev_length.
  ENDMETHOD.