  METHOD setup.

    DATA:
      lo_core_util           TYPE REF TO if_ngc_core_util,
      lo_chr_util_funcmod    TYPE REF TO if_ngc_core_chr_util_funcmod,
      lo_chr_util_checktable TYPE REF TO if_ngc_core_chr_util_chcktable.


    go_sql_environment->clear_doubles( ).

    mo_cut ?= cl_ngc_core_factory=>get_new_chr_persistency( ).

    " Initialize stubs
    lo_core_util ?= cl_abap_testdouble=>create( 'if_ngc_core_util' ).
    mo_cut->mo_core_util = lo_core_util.

    lo_chr_util_funcmod ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_util_funcmod' ).
    mo_cut->mo_chr_util_funcmod = lo_chr_util_funcmod.

    lo_chr_util_checktable ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_util_chcktable' ).
    mo_cut->mo_chr_util_chcktable = lo_chr_util_checktable.

  ENDMETHOD.