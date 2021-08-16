METHOD SEND_CLFMAS_IDOC.

  DATA:
    lv_created_comm_idocs LIKE sy-tabix,
    lv_total_idoc         LIKE sy-tabix VALUE 0,
    ls_idoc_control       TYPE edidc,
    lt_idoc_control       TYPE tt_edidc,
    lv_object_id          TYPE drf_object_id,
    ls_drf_clf_objkey     TYPE cmd_bs_clf_key_objkey.

  READ TABLE ct_idoc_cntrl INTO ls_idoc_control INDEX 1.
  CLEAR: ct_idoc_cntrl.

  mo_drf_ale_info->determine_message_type(
    EXPORTING
      iv_mestyp        = CONV #( if_ngc_drf_c=>gc_idoc_type_clfmas )
      iv_target_system = ls_idoc_control-rcvprn " Logical System
    IMPORTING
      ev_mestyp        = DATA(lv_mestyp)
*     es_message       =
  ).

  LOOP AT it_clf_data ASSIGNING FIELD-SYMBOL(<ls_clf_data>).

    CLEAR: lv_created_comm_idocs.

    mo_idoc_functions->masteridoc_create_clfmas(
      EXPORTING
        object                 = <ls_clf_data>-objekt
        class_type             = <ls_clf_data>-klart
        type_of_classification = <ls_clf_data>-mafid
*       KEY_DATE               = SY-DATUM
*       CHANGE_NUMBER          =
        rcvpfc                 = ' '
        rcvprn                 = ls_idoc_control-rcvprn
        rcvprt                 = ls_idoc_control-rcvprt
        sndpfc                 = ' '
        sndprn                 = '          '
        sndprt                 = '  '
        message_type           = lv_mestyp
*       DLOCK_IGNORE           = ' '
*       MESCOD                 = '   '
      IMPORTING
        created_comm_idocs     = lv_created_comm_idocs
      CHANGING
        te_idoc_control        = lt_idoc_control
*       it_clint_range         =
    ).

    APPEND LINES OF lt_idoc_control TO ct_idoc_cntrl.
    lv_total_idoc = lv_total_idoc + lv_created_comm_idocs.
    CLEAR: ls_drf_clf_objkey, lv_object_id.
    ls_drf_clf_objkey-object_table = <ls_clf_data>-obtab.
    ls_drf_clf_objkey-klart        = <ls_clf_data>-klart.
    ls_drf_clf_objkey-objkey       = <ls_clf_data>-objekt.
    " copy to one field
    lv_object_id = ls_drf_clf_objkey.
    update_replication_data(
      EXPORTING
        iv_object_id   = lv_object_id
        it_idoc_result = lt_idoc_control
        iv_messagetype = if_ngc_drf_c=>gc_idoc_type_clfmas
      CHANGING
        ct_obj_rep_sta = ct_obj_rep_sta ).
  ENDLOOP.

  IF ms_runtime_param-bal IS BOUND.
    MESSAGE i000(cmd_bs_mat_drf_msg) WITH if_ngc_drf_c=>gc_idoc_type_clfmas lv_total_idoc INTO DATA(lv_msg) ##NEEDED .
    ms_runtime_param-bal->add_msg(
      iv_msgty = sy-msgty
      iv_msgno = sy-msgno
      iv_msgid = sy-msgid
      iv_msgv1 = sy-msgv1
      iv_msgv2 = sy-msgv2
      iv_msgv3 = sy-msgv3
      iv_msgv4 = sy-msgv4
    ).

    LOOP AT ct_idoc_cntrl ASSIGNING FIELD-SYMBOL(<ls_idoc_control>).
      ms_runtime_param-bal->add_msg_idoc(
        iv_idoc_number = <ls_idoc_control>-docnum
        iv_serv_impl   = if_ngc_drf_c=>gc_clfmas_drf_outb_impl " Outbound Implementation for Classification IDOC CLFMAS
*       ir_object      =
      ).
    ENDLOOP.
  ENDIF.

ENDMETHOD.