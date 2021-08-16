  METHOD verify_classification_setup.
    cl_abap_testdouble=>verify_expectations( double = mo_ngc_classification ).
  ENDMETHOD.