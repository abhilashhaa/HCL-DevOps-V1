METHOD send_cif_characteristic.

  DATA:
    lt_cabn            TYPE tt_cabn,
    lt_cabnt           TYPE tt_cabnt,
    lt_cawn            TYPE tt_cawn,
    lt_cawnt           TYPE tt_cawnt,
    lt_cabnz           TYPE tt_cabnz,
    lt_tcme            TYPE tt_tcme,
    lv_no_execute      TYPE syst_input,
    lt_ret             TYPE bapirettab,
    ls_ctrlparams      TYPE cifctrlpar,
    lt_cif_cabn        TYPE if_ngc_drf_ewm_util=>tt_cif_cabn,
    lt_cif_cawn        TYPE if_ngc_drf_ewm_util=>tt_cif_cawn,
    lt_cif_cawnt       TYPE if_ngc_drf_ewm_util=>tt_cif_cawnt,
    lt_char_fieldnames TYPE cl_mfle_cif_clcg_mapper=>ty_t_char_fieldnames.

  lt_cabn  = it_cabn.
  lt_cabnt = it_cabnt.
  lt_cawn  = it_cawn.
  lt_cawnt = it_cawnt.
  lt_cabnz = it_cabnz.
  lt_tcme  = it_tcme.

  " own logical system (source system)
  io_ngc_drf_ewm_util->ale_own_logical_system_get(
    IMPORTING
      ev_own_logical_system = ls_ctrlparams-logsrcsys
      ev_subrc              = DATA(lv_subrc)
  ).
  IF lv_subrc <> 0.
    IF is_runtime_param-bal IS BOUND.
      is_runtime_param-bal->add_msg(
        iv_msgty = sy-msgty
        iv_msgno = sy-msgno
        iv_msgid = sy-msgid
        iv_msgv1 = sy-msgv1
        iv_msgv2 = sy-msgv2
        iv_msgv3 = sy-msgv3
        iv_msgv4 = sy-msgv4
      ).
    ENDIF.
  ENDIF.

  ls_ctrlparams-logdestsys = is_runtime_param-logsys. " destination system

  " set queue name, queue type and operation mode
  IF is_runtime_param-dlmod = if_drf_const=>mode_directly.
    ls_ctrlparams-trfcchn = if_drf_ewm_out=>gc_queue_name_prefix && if_ngc_drf_c=>gc_queue_name_cls_chr.
  ELSE.
    ls_ctrlparams-trfcchn = if_drf_ewm_out=>gc_queue_name_prefix && if_drf_ewm_out=>gc_queue_name_inintial.
  ENDIF.
  ls_ctrlparams-queuetype = 'I'.
  ls_ctrlparams-opmode    = 'I'.

  " set trfc queue properties
  io_ngc_drf_ewm_util->rfc_trfc_set_qin_properties(
    EXPORTING
      iv_qin_name   = ls_ctrlparams-trfcchn
      iv_no_execute = lv_no_execute
    IMPORTING
      ev_subrc      = lv_subrc
  ).
  IF lv_subrc <> 0.
    IF is_runtime_param-bal IS BOUND.
      is_runtime_param-bal->add_msg(
        iv_msgty = sy-msgty
        iv_msgno = sy-msgno
        iv_msgid = sy-msgid
        iv_msgv1 = sy-msgv1
        iv_msgv2 = sy-msgv2
        iv_msgv3 = sy-msgv3
        iv_msgv4 = sy-msgv4
      ).
    ENDIF.
    RETURN.
  ENDIF.

  io_ngc_drf_ewm_util->expand_tcme_for_cdp(
    CHANGING
      ct_tcme       = lt_tcme
      cs_ctrlparams = ls_ctrlparams
  ).

  io_ngc_drf_ewm_util->change_classtype_tcme(
    EXPORTING
      iv_class_type_from = if_ngc_drf_c=>gc_batch_classtype_mat_level
      iv_class_type_to   = if_ngc_drf_c=>gc_ewm_classtype_version
    CHANGING
      ct_tcme            = lt_tcme
      cs_ctrlparams      = ls_ctrlparams
  ).

  io_ngc_drf_ewm_util->apo_irrelevant_tcme(
    CHANGING
      ct_tcme       = lt_tcme
      cs_ctrlparams = ls_ctrlparams
  ).

  " Adjust Material number length
  TRY.
      lt_char_fieldnames = VALUE #( ( field = 'ATSCH' longfield = 'ATSCH_LONG' value_type = cl_cls_chk_mapper=>gc_char_value_fieldname-char_value_template char_id = 'ATINN' ) ).
      io_ngc_drf_ewm_util->cif_mfle_map_clcg_export_mass(
        EXPORTING
          it_char_fieldnames  = lt_char_fieldnames
          it_table            = lt_cabn
        IMPORTING
          et_table            = lt_cif_cabn
      ).
      lt_char_fieldnames = VALUE #( ( field = 'ATWRT' longfield = 'ATWRT_LONG' value_type = cl_cls_chk_mapper=>gc_char_value_fieldname-char_value char_id = 'ATINN' ) ).
      io_ngc_drf_ewm_util->cif_mfle_map_clcg_export_mass(
        EXPORTING
          it_char_fieldnames  = lt_char_fieldnames
          it_table            = lt_cawn
        IMPORTING
          et_table            = lt_cif_cawn
      ).
      lt_char_fieldnames = VALUE #( ( field = 'ATWTB' longfield = 'ATWTB_LONG' value_type = cl_cls_chk_mapper=>gc_char_value_fieldname-char_value_descr char_id = 'ATINN' ) ).
      io_ngc_drf_ewm_util->cif_mfle_map_clcg_export_mass(
        EXPORTING
          it_char_fieldnames  = lt_char_fieldnames
          it_table            = lt_cawnt
        IMPORTING
          et_table            = lt_cif_cawnt
      ).
    CATCH cx_cls_chk_mapper INTO DATA(lx_cls_chk_mapper) ##NEEDED.
      ASSERT 1 = 2.
  ENDTRY.
  " Characteristics can be longer than 30 chars for local APO system.

  " characteristics can't be longer than 30 characters for sending via CIF
  LOOP AT lt_cif_cabn ASSIGNING FIELD-SYMBOL(<fs_cif_cabn>).
    CHECK <fs_cif_cabn>-anzst > 30 ##NUMBER_OK.
    MESSAGE a245(xc) WITH <fs_cif_cabn>-atnam INTO DATA(lv_dummy) ##NEEDED.
    IF is_runtime_param-bal IS BOUND.
      is_runtime_param-bal->add_msg(
        iv_msgty = sy-msgty
        iv_msgno = sy-msgno
        iv_msgid = sy-msgid
        iv_msgv1 = sy-msgv1
        iv_msgv2 = sy-msgv2
        iv_msgv3 = sy-msgv3
        iv_msgv4 = sy-msgv4
      ).
    ENDIF.
    RETURN.
  ENDLOOP.

  " call APO CIF Characteristic FM
  io_ngc_drf_ewm_util->cif_/sapapo/cif_chr30_inb(
    EXPORTING
      is_control_parameter = ls_ctrlparams
      iv_rfc_dest          = is_runtime_param-rfcdest
    CHANGING
      ct_cabn              = lt_cif_cabn
      ct_cabnt             = lt_cabnt
      ct_cawn              = lt_cif_cawn
      ct_cawnt             = lt_cif_cawnt
      ct_cabnz             = lt_cabnz
      ct_tcme              = lt_tcme
*     ct_extensionin       =
      ct_return            = lt_ret ).

  IF is_runtime_param-bal IS BOUND.
    is_runtime_param-bal->add_msg_from_bapi( lt_ret ).
  ENDIF.

ENDMETHOD.