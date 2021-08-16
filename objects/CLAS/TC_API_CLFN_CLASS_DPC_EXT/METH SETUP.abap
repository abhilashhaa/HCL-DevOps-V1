  METHOD setup.

    DATA ls_characteristicdetail TYPE cl_lo_vchclf_mpc=>ts_characteristicdetail.

    mo_cut = NEW cl_api_clfn_class_dpc_ext( ).
*    mo_cut->mo_class_dpc ?= cl_abap_testdouble=>create( 'cl_api_clfn_class_dpc_ext ' ).

  ENDMETHOD.