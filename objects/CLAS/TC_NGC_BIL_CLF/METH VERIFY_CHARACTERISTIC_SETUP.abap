  METHOD VERIFY_CHARACTERISTIC_SETUP.
    cl_abap_testdouble=>verify_expectations( double = mo_ngc_characteristic ).
  ENDMETHOD.