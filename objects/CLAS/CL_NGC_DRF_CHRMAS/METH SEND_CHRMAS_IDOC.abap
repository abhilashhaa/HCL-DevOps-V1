METHOD SEND_CHRMAS_IDOC.

  DATA:
    lv_created_comm_idocs LIKE sy-tabix,
    lv_total_idoc         LIKE sy-tabix VALUE 0,
    ls_idoc_control       TYPE edidc,
    lt_idoc_control       TYPE edidc_tt,
    lv_object_id          TYPE drf_object_id,
    ls_drf_chr_objkey     TYPE ngcs_drf_chrmas_object_key.

  READ TABLE ct_idoc_cntrl INTO ls_idoc_control INDEX 1.
  CLEAR: ct_idoc_cntrl.

  mo_drf_ale_info->determine_message_type(
    EXPORTING
      iv_mestyp        = CONV #( if_ngc_drf_c=>gc_idoc_type_chrmas )
      iv_target_system = ls_idoc_control-rcvprn " Logical System
    IMPORTING
      ev_mestyp        = DATA(lv_mestyp)
*     es_message       =
  ).

  LOOP AT it_chr_key ASSIGNING FIELD-SYMBOL(<ls_chr_key>).

    CLEAR: lv_created_comm_idocs.

    mo_idoc_functions->masteridoc_create_chrmas(
      EXPORTING
        charact            = <ls_chr_key>-atnam
*        key_date           = SY-DATUM
*        change_number      =
        rcvpfc             = ' '
        rcvprn             = ls_idoc_control-rcvprn
        rcvprt             = ls_idoc_control-rcvprt
        sndpfc             = ' '
        sndprn             = '          '
        sndprt             = '  '
        message_type       = lv_mestyp
*        dlock_ignore       = SPACE
*        mescod             = '   '
      IMPORTING
        created_comm_idocs = lv_created_comm_idocs
      CHANGING
        te_idoc_control    = lt_idoc_control
    ).

    APPEND LINES OF lt_idoc_control TO ct_idoc_cntrl.
    lv_total_idoc = lv_total_idoc + lv_created_comm_idocs.
    CLEAR: ls_drf_chr_objkey, lv_object_id.
    ls_drf_chr_objkey-atnam = <ls_chr_key>-atnam.
    " copy to one field
    lv_object_id = ls_drf_chr_objkey.
    me->update_replication_data(
      EXPORTING
        iv_object_id   = lv_object_id
        it_idoc_result = lt_idoc_control
        iv_messagetype = if_ngc_drf_c=>gc_idoc_type_chrmas
      CHANGING
        ct_obj_rep_sta = ct_obj_rep_sta ).

  ENDLOOP.

  IF ms_runtime_param-bal IS BOUND.
    MESSAGE i000(cmd_bs_mat_drf_msg) WITH if_ngc_drf_c=>gc_idoc_type_chrmas lv_total_idoc INTO DATA(lv_msg) ##NEEDED .
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
        iv_serv_impl   = if_ngc_drf_c=>gc_chrmas_drf_outb_impl " Outbound Implementation for Characteristic IDOC CHRMAS
*       ir_object      =
      ).
    ENDLOOP.
  ENDIF.

ENDMETHOD.