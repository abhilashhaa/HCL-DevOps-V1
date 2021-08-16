  METHOD get_ext.

    rv_ext = find_param( it_params = it_params
                         iv_name = c_param_names-fileext ).
    SHIFT rv_ext LEFT DELETING LEADING '.'.

  ENDMETHOD.