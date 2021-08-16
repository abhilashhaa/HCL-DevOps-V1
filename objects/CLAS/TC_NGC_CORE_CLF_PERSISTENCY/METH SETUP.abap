  METHOD setup.

    DATA:
      lo_clf_util        TYPE REF TO if_ngc_core_clf_util,
      lo_clf_locking     TYPE REF TO if_ngc_core_clf_locking,
      lo_clf_db_update   TYPE REF TO if_ngc_core_clf_db_update,
      lo_clf_bte         TYPE REF TO if_ngc_core_clf_bte,
      lo_cls_persistency TYPE REF TO if_ngc_core_cls_persistency.


    go_sql_environment->clear_doubles( ).

    mo_cut ?= cl_ngc_core_factory=>get_new_clf_persistency( ).

    lo_clf_util ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_util' ).
    mo_cut->mo_util = lo_clf_util.

    lo_clf_locking ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_locking' ).
    mo_cut->mo_locking = lo_clf_locking.

    lo_clf_db_update ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_db_update' ).
    mo_cut->mo_db_update = lo_clf_db_update.

    lo_clf_bte ?= cl_abap_testdouble=>create( 'if_ngc_core_clf_bte' ).
    mo_cut->mo_bte = lo_clf_bte.

    lo_cls_persistency ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_persistency' ).
    mo_cut->mo_cls_persistency = lo_cls_persistency.

  ENDMETHOD.