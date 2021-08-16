  METHOD verify_api_setup.
    cl_abap_testdouble=>verify_expectations( double = mo_ngc_api ).
  ENDMETHOD.