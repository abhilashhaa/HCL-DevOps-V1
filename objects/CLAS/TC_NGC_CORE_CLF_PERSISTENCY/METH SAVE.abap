  METHOD save.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_ausp_change_data(
      EXPORTING
        it_ausp_change = th_ngc_core_clf_pers_data=>get_ausp_changes_2017( )
      IMPORTING
        et_ausp_exp    = DATA(lt_ausp_exp) ).

    me->get_kssk_change_data(
      EXPORTING
        it_kssk_change = th_ngc_core_clf_pers_data=>get_kssk_changes_2017( )
        it_class_data  = th_ngc_core_clf_pers_data=>get_class_data_2017( )
      IMPORTING
        et_kssk_insert_exp = DATA(lt_kssk_insert_exp)
        et_kssk_delete_exp = DATA(lt_kssk_delete_exp) ).

    me->get_inob_change_data(
      EXPORTING
        it_inob_change = th_ngc_core_clf_pers_data=>get_inob_changes_2017( )
      IMPORTING
        et_inob_insert_exp = DATA(lt_inob_insert_exp)
        et_inob_delete_exp = DATA(lt_inob_delete_exp) ).

    me->get_classification_data(
      EXPORTING
        it_classification = VALUE #(
          ( classification = th_ngc_core_clf_pers_data=>get_classification_2017( ) keydate = th_ngc_core_clf_pers_data=>cv_keydate_2017 ) )
        it_valuation      = VALUE #(
          ( valuation = th_ngc_core_clf_pers_data=>get_valuation_2017( ) keydate = th_ngc_core_clf_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_classification_exp = DATA(lt_classification) ).

    me->get_clmdpc_data(
      EXPORTING
        it_ausp = lt_ausp_exp
        it_kssk = lt_kssk_insert_exp
      IMPORTING
        et_clmdpc = DATA(lt_clmdpc_exp) ).

    me->expect_db_update(
        it_ausp        = lt_ausp_exp
        it_kssk_insert = lt_kssk_insert_exp
        it_kssk_delete = lt_kssk_delete_exp
        it_inob_insert = lt_inob_insert_exp
        it_inob_delete = lt_inob_delete_exp
        it_clmdpc      = lt_clmdpc_exp
        iv_times       = 2 ).

    mo_cut->mt_loaded_data  = lt_classification.
    mo_cut->mt_kssk_changes = th_ngc_core_clf_pers_data=>get_kssk_changes_2017( ).
    mo_cut->mt_ausp_changes = th_ngc_core_clf_pers_data=>get_ausp_changes_2017( ).
    mo_cut->mt_inob_changes = th_ngc_core_clf_pers_data=>get_inob_changes_2017( ).
    mo_cut->mt_classes      = th_ngc_core_clf_pers_data=>get_class_data_2017( ).

    DO 2 TIMES.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_clf_persistency~save( ).

    ENDDO.

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_testdouble=>verify_expectations( mo_cut->mo_db_update ).

  ENDMETHOD.