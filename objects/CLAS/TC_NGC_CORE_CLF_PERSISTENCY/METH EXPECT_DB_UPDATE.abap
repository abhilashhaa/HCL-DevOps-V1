  METHOD expect_db_update.

    cl_abap_testdouble=>configure_call( mo_cut->mo_db_update
      )->and_expect(
      )->is_called_times( iv_times ).
    mo_cut->mo_db_update->clf_db_update(
      it_ausp_fm        = it_ausp
      it_kssk_insert_fm = it_kssk_insert
      it_kssk_delete_fm = it_kssk_delete
      it_inob_insert_fm = it_inob_insert
      it_inob_delete_fm = it_inob_delete
      it_clmdcp         = it_clmdpc ).

  ENDMETHOD.