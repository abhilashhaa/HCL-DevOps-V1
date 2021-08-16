  METHOD add_fm_param_exporting.

    DATA: ls_param LIKE LINE OF ct_param.

    ls_param-kind = abap_func_exporting.
    ls_param-name = iv_name.
    GET REFERENCE OF ig_value INTO ls_param-value.

    INSERT ls_param INTO TABLE ct_param.

  ENDMETHOD.