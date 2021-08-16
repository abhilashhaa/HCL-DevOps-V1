  METHOD if_ngc_core_chr_util_chcktable~get_table_details.

    CLEAR: et_field_list, et_field_info.

    mo_table_data_handler->get_table_details(
      EXPORTING
        iv_table_name = iv_table_name
      IMPORTING
        et_field_list = et_field_list
        et_field_info = et_field_info
      EXCEPTIONS
        not_found     = 1 ).

  ENDMETHOD.