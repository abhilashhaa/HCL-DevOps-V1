METHOD if_drf_outbound~send_message.

  DATA:
    lt_idoc_clfmas_control TYPE tt_edidc,
    lt_clf_data            TYPE tt_clobjekte.

  CLEAR: et_file_data, et_message.

  " Fetch the business system for the replication model
  IF mv_bus_sys_fetched = abap_false.
    mo_drf_access_cust_data->select_business_sys_for_appl(
      EXPORTING
        iv_appl         = ms_runtime_param-appl
        iv_outb_impl    = ms_runtime_param-outb_impl
      IMPORTING
        et_bus_sys_tech = DATA(lt_bus_sys_tech) ).
    mv_bus_sys_fetched = abap_true.
  ENDIF.

  READ TABLE ct_obj_rep_sta INTO DATA(ls_obj_rep) INDEX 1.

  READ TABLE lt_bus_sys_tech INTO DATA(ls_bus_sys_tech) WITH KEY business_system = ls_obj_rep-business_system.

  APPEND VALUE #( rcvprn = ls_bus_sys_tech-logsys rcvprt = if_ngc_drf_c=>gc_rcvprt_log_sys ) TO lt_idoc_clfmas_control.

  lt_clf_data = mt_clf_data.

  IF iv_object_count > 0.
    handle_clf_data(
      EXPORTING
        iv_packet_size = iv_object_count
      CHANGING
        ct_clf_data    = lt_clf_data ).
  ENDIF.

  send_clfmas_idoc(
    EXPORTING
      it_clf_data    = lt_clf_data
    CHANGING
      ct_idoc_cntrl  = lt_idoc_clfmas_control
      ct_obj_rep_sta = ct_obj_rep_sta ).

ENDMETHOD.