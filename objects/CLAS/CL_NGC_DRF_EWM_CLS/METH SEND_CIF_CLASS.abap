METHOD send_cif_class.

  DATA:
    lt_klah_i     TYPE tt_klah,
    lt_ret        TYPE bapirettab,
    ls_ctrlparams TYPE cifctrlpar.

  FIELD-SYMBOLS:
    <ls_ksml> TYPE ksml.

  mo_ewm_util->get_class_data(
    EXPORTING
      it_bo_key        = it_relevant_objects
    IMPORTING
      et_class_header  = DATA(lt_class_header)
      et_charact_tab   = DATA(lt_charact_tab)
      et_catchword_tab = DATA(lt_catchword_tab)
  ).

  LOOP AT lt_class_header ASSIGNING FIELD-SYMBOL(<ls_class_header>).
    READ TABLE it_relevant_objects TRANSPORTING NO FIELDS
      WITH KEY class = <ls_class_header>-class
               klart = <ls_class_header>-klart.
    IF sy-subrc = 0.
      APPEND <ls_class_header> TO lt_klah_i.
    ENDIF.
  ENDLOOP.

  IF lt_klah_i IS INITIAL.
    RETURN.
  ENDIF.

  " Overwritten characteristics are not supported in CIF integration.
  " Original of this code is in FM CIF_CHR_SEND (Note 1457502)
  " This code clears the reference to the key of the overwrite characteristic.
  IF lt_charact_tab IS NOT INITIAL.
    SORT lt_charact_tab BY omerk DESCENDING.
    READ TABLE lt_charact_tab INDEX 1 ASSIGNING <ls_ksml>.
    IF <ls_ksml>-omerk IS NOT INITIAL.
      LOOP AT lt_charact_tab ASSIGNING <ls_ksml>.
        IF <ls_ksml>-omerk IS INITIAL.
          EXIT.
        ENDIF.
        CLEAR <ls_ksml>-omerk.
      ENDLOOP.
    ENDIF.
  ENDIF.

  mo_ewm_util->ale_own_logical_system_get(
    IMPORTING
      ev_own_logical_system = ls_ctrlparams-logsrcsys
      ev_subrc              = DATA(lv_subrc)
  ).
  IF lv_subrc = 1.
    IF ms_runtime_param-bal IS BOUND.
      MESSAGE e001(b2) INTO DATA(lv_dummy) ##NEEDED.
      ms_runtime_param-bal->add_msg(
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

  ls_ctrlparams-logdestsys = ms_runtime_param-logsys. " destination system

  " set queue name, queue type and operation mode
  IF ms_runtime_param-dlmod = if_drf_const=>mode_directly.
    ls_ctrlparams-trfcchn = if_drf_ewm_out=>gc_queue_name_prefix && if_ngc_drf_c=>gc_queue_name_cls_chr.
  ELSE.
    ls_ctrlparams-trfcchn = if_drf_ewm_out=>gc_queue_name_prefix && if_drf_ewm_out=>gc_queue_name_inintial.
  ENDIF.
  ls_ctrlparams-queuetype  = 'I'.
  ls_ctrlparams-opmode     = 'I'.

  " now make sure newly added characteristics are sent to APO
  send_characteristics(
    EXPORTING
      it_ksml        = lt_charact_tab
    CHANGING
      cs_ctrlparams  = ls_ctrlparams
      ct_obj_rep_sta = ct_obj_rep_sta
  ).

  mo_ewm_util->change_classtype_class(
    EXPORTING
      iv_class_type_from = if_ngc_drf_c=>gc_batch_classtype_mat_level
      iv_class_type_to   = if_ngc_drf_c=>gc_ewm_classtype_version
      is_ctrlparams      = ls_ctrlparams
    CHANGING
      ct_klah            = lt_klah_i
      ct_ksml            = lt_charact_tab
  ).

  mo_ewm_util->apo_irrelevant_types_class(
    CHANGING
      ct_klah       = lt_klah_i
      ct_ksml       = lt_charact_tab
      cs_ctrlparams = ls_ctrlparams
  ).

  mo_cif_functions->/sapapo/cif_cla30_inb(
    EXPORTING
      iv_rfc_dest          = ms_runtime_param-rfcdest
      is_control_parameter = ls_ctrlparams
      iv_logsrcsys         = ls_ctrlparams-logsrcsys
*    IMPORTING
*     ev_subrc             =
    CHANGING
      ct_klah              = lt_klah_i
      ct_swor              = lt_catchword_tab
      ct_ksml              = lt_charact_tab
*     ct_class_match       =
*     ct_extensionin       =
      ct_return            = lt_ret
  ).

  IF ms_runtime_param-bal IS BOUND.
    ms_runtime_param-bal->add_msg_from_bapi( lt_ret ).
  ENDIF.

ENDMETHOD.