  METHOD add_fm_param_tables.

    DATA: ls_param LIKE LINE OF ct_param.

    ls_param-kind = abap_func_tables.
    ls_param-name = iv_name.
    GET REFERENCE OF ct_value INTO ls_param-value.

    INSERT ls_param INTO TABLE ct_param.

  ENDMETHOD.