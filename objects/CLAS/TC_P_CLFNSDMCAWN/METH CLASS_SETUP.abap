  METHOD class_setup.

    environment = cl_cds_test_environment=>create(
      i_for_entity      = 'P_CLFNSDMCAWN'
      test_associations = abap_true
    ).

  ENDMETHOD.