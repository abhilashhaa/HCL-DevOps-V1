  METHOD stub_all.
    DATA lo_clf_persistency TYPE REF TO if_ngc_core_clf_persistency.

    lo_clf_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_persistency' ).

    cl_ngc_core_factory=>go_clf_persistency = lo_clf_persistency.
  ENDMETHOD.