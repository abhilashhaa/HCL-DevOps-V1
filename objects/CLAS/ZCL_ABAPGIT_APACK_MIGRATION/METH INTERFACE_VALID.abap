  METHOD interface_valid.

    FIELD-SYMBOLS: <lv_interface_version> TYPE i.

    ASSIGN ('ZIF_APACK_MANIFEST')=>('CO_INTERFACE_VERSION') TO <lv_interface_version>.
    rv_interface_valid = boolc( <lv_interface_version> IS ASSIGNED
      AND <lv_interface_version> >= c_apack_interface_version ).

  ENDMETHOD.