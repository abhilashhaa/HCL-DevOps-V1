  METHOD interface_exists.

    DATA: lv_interface_name TYPE seoclsname.

    SELECT SINGLE clsname FROM seoclass INTO lv_interface_name WHERE clsname = c_interface_name.
    rv_interface_exists = boolc( sy-subrc = 0 ).

  ENDMETHOD.