  METHOD setup.

    DATA:
      lo_util_intersect  TYPE REF TO if_ngc_core_cls_util_intersect,
      lo_chr_persistency TYPE REF TO if_ngc_core_chr_persistency.


    go_sql_environment->clear_doubles( ).

    mo_cut ?= cl_ngc_core_factory=>get_new_cls_persistency( ).

    lo_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_util_intersect = lo_util_intersect.

    lo_chr_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_persistency' ).
    mo_cut->mo_chr_persistency = lo_chr_persistency.

  ENDMETHOD.