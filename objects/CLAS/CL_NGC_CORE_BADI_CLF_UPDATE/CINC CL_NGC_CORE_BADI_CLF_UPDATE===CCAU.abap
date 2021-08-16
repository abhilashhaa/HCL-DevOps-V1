CLASS ltc_ngc_core_badi_clf_update DEFINITION DEFERRED.
CLASS cl_ngc_core_badi_clf_update DEFINITION LOCAL FRIENDS ltc_ngc_core_badi_clf_update.

CLASS ltc_ngc_core_badi_clf_update DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      go_badi_clf_update TYPE REF TO cl_ngc_core_badi_clf_update.

    METHODS:
      setup.

    METHODS:
      before_update_successful FOR TESTING,
      after_update_successful FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_core_badi_clf_update IMPLEMENTATION.
  METHOD setup.
    go_badi_clf_update = NEW #( ).
    go_badi_clf_update->mo_cls_hier_maint ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_hier_maint' ).
  ENDMETHOD.

  METHOD before_update_successful.
    DATA:
      lv_new_date TYPE datuv,
      lt_kssk_ins TYPE tt_kssk,
      lt_kssk_upd TYPE tt_kssk,
      lt_kssk_del TYPE tt_kssk.

    lt_kssk_ins = VALUE #(
      ( objek = '0000000001' clint = '0000000002' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  ) ).
    lt_kssk_del = VALUE #(
      ( objek = '0000000003' clint = '0000000004' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  ) ).
    lt_kssk_upd = VALUE #(
      ( objek = '0000000005' clint = '0000000006' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  ) ).
    lv_new_date = '20100101'.

    go_badi_clf_update->if_ex_cacl_classficatn_update~before_update(
      iv_new_date = lv_new_date
      it_kssk_insert = lt_kssk_ins
      it_kssk_delete = lt_kssk_del
      it_kssk_update = lt_kssk_upd ).
  ENDMETHOD.

  METHOD after_update_successful.
    go_badi_clf_update->mt_kssk_ins = VALUE #(
      ( objek = '0000000001' clint = '0000000002' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  ) ).
    go_badi_clf_update->mt_kssk_del = VALUE #(
      ( objek = '0000000003' clint = '0000000004' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  ) ).
    go_badi_clf_update->mt_kssk_upd = VALUE #(
      ( objek = '0000000005' clint = '0000000006' adzhl = '0001'
        datuv = '20020101'   datub = '20031231'   klart = '001'
        aennr = '20020101'   mafid = 'K'          lkenz = ' '  ) ).
    go_badi_clf_update->mv_new_date = '20200101'.

    cl_abap_testdouble=>configure_call( go_badi_clf_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_clf_update->mo_cls_hier_maint->update( ).

    cl_abap_testdouble=>configure_call( go_badi_clf_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_clf_update->mo_cls_hier_maint->update_relations(
      it_relations = go_badi_clf_update->mt_kssk_ins
      iv_action    = 'I' ).

    cl_abap_testdouble=>configure_call( go_badi_clf_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_clf_update->mo_cls_hier_maint->update_relations(
      it_relations = go_badi_clf_update->mt_kssk_upd
      iv_action    = 'U'
      iv_new_date  = go_badi_clf_update->mv_new_date ).

    cl_abap_testdouble=>configure_call( go_badi_clf_update->mo_cls_hier_maint )->and_expect( )->is_called_once( ).
    go_badi_clf_update->mo_cls_hier_maint->update_relations(
      it_relations = go_badi_clf_update->mt_kssk_del
      iv_action    = 'D' ).

    go_badi_clf_update->if_ex_cacl_classficatn_update~after_update( ).

    cl_abap_testdouble=>verify_expectations( go_badi_clf_update->mo_cls_hier_maint ).
  ENDMETHOD.
ENDCLASS.