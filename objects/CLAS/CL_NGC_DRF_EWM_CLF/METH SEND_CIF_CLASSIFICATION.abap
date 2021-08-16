METHOD send_cif_classification.

  TYPES: ty_atinn_range TYPE RANGE OF atinn.

  DATA:
    lv_no_execute      TYPE syst_input,
    ls_cuobn_fieldname TYPE cl_mfle_cif_clcg_mapper=>ty_s_fieldnames,
    ls_matnr_fieldname TYPE cl_mfle_cif_clcg_mapper=>ty_s_fieldnames,
    lt_char_fieldnames TYPE cl_mfle_cif_clcg_mapper=>ty_t_char_fieldnames,
    lt_claf_kssk_cif   TYPE TABLE OF cif_kssk_cbc,
    lt_claf_inob_cif   TYPE TABLE OF cif_inob_cbc,
    lt_claf_ausp_cif   TYPE TABLE OF cif_ausp_cbc,
    ls_atinn_range     TYPE LINE OF ty_atinn_range,
    lt_atinn_range     TYPE ty_atinn_range,
    lt_cif_cabn        TYPE TABLE OF cabn,
    lt_ret             TYPE bapirettab,
    ls_ctrlparams      TYPE cifctrlpar,
    ls_rmclf           TYPE rmclf.

  CLEAR: ls_ctrlparams.

  mo_ewm_util->get_classification_data(
    EXPORTING
      it_bo_keys             = it_relevant_objects
    IMPORTING
      et_kssk_classification = DATA(lt_kssk)
      et_inob_classification = DATA(lt_inob)
      et_ausp_classification = DATA(lt_ausp)
  ).

  " -----------------------------------------------------------------
  " The following coding is adapted from CIF_CLAF_OUTBOUND,
  " Replace 023 with 230
  LOOP AT lt_kssk ASSIGNING FIELD-SYMBOL(<ls_kssk>).
    <ls_kssk>-klart = if_ngc_drf_c=>gc_ewm_classtype_version.
  ENDLOOP.
  LOOP AT lt_inob ASSIGNING FIELD-SYMBOL(<ls_inob>).
    <ls_inob>-klart = if_ngc_drf_c=>gc_ewm_classtype_version.
  ENDLOOP.
  LOOP AT lt_ausp ASSIGNING FIELD-SYMBOL(<ls_ausp>).
    <ls_ausp>-klart = if_ngc_drf_c=>gc_ewm_classtype_version.
  ENDLOOP.
  " end of CIF_CLAF_OUTBOUND adaptions
  " -----------------------------------------------------------------

  " -----------------------------------------------------------------
  " Some parts of the following coding were adapted from CIF_CLAF_SEND
  " -----------------------------------------------------------------
  TRY.
      mo_ewm_util->cif_mfle_set_buf(
        EXPORTING
          it_table = lt_inob
      ).

      ls_cuobn_fieldname = VALUE #( field = 'OBJEK' longfield = 'OBJEK_LONG' ).

      mo_ewm_util->cif_mfle_map_clcg_export_mass(
        EXPORTING
          is_cuobn_fieldnames = ls_cuobn_fieldname
          it_table            = lt_kssk
        IMPORTING
          et_table            = lt_claf_kssk_cif
      ).

      ls_matnr_fieldname = VALUE #( field = 'MATNR' longfield = 'MATNR_LONG' ).
      mo_ewm_util->cif_mfle_map_clcg_export_mass(
        EXPORTING
          is_matnr_fieldnames = ls_matnr_fieldname
          is_cuobn_fieldnames = ls_cuobn_fieldname
          it_table            = lt_inob
        IMPORTING
          et_table            = lt_claf_inob_cif
      ).

      lt_char_fieldnames = VALUE #( ( field = 'ATWRT' longfield = 'ATWRT_LONG' value_type = cl_cls_chk_mapper=>gc_char_value_fieldname-char_value char_id = 'ATINN' ) ).
      mo_ewm_util->cif_mfle_map_clcg_export_mass(
        EXPORTING
          it_char_fieldnames  = lt_char_fieldnames
          is_cuobn_fieldnames = ls_cuobn_fieldname
          it_table            = lt_ausp
        IMPORTING
          et_table            = lt_claf_ausp_cif
      ).

      mo_ewm_util->cif_mfle_reset_buf( ).
    CATCH cx_cls_chk_mapper INTO DATA(lx_cls_chk_mapper) ##NEEDED.
      ASSERT 1 = 2.
  ENDTRY.

  ls_ctrlparams-logdestsys = ms_runtime_param-logsys. " destination system

  " own logical system (source system)
  mo_ewm_util->ale_own_logical_system_get(
   IMPORTING
     ev_own_logical_system = ls_ctrlparams-logsrcsys
     ev_subrc              = DATA(lv_subrc)
  ).
  IF lv_subrc <> 0.
    IF ms_runtime_param-bal IS BOUND.
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

*   Don't send long material with char. or long classification via CIF
  "Check material length
  LOOP AT lt_claf_inob_cif ASSIGNING FIELD-SYMBOL(<fs_cif_inob>).
    CHECK <fs_cif_inob>-obtab = if_ngc_drf_c=>gc_product_header_dbtable OR
          <fs_cif_inob>-obtab = if_ngc_drf_c=>gc_batch_mat_level_dbtable.
    CHECK NOT <fs_cif_inob>-objek_long IS INITIAL.
    IF <fs_cif_inob>-objek IS INITIAL.
      MESSAGE a245(xc) WITH <fs_cif_inob>-objek_long(40) INTO DATA(dummy) ##NEEDED.
      IF ms_runtime_param-bal IS BOUND.
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
      RETURN.
    ENDIF.
  ENDLOOP.

  "Check classification length
  ls_atinn_range-sign   = 'I'.
  ls_atinn_range-option = 'EQ'.
  LOOP AT lt_claf_ausp_cif ASSIGNING FIELD-SYMBOL(<fs_cif_ausp>).
    ls_atinn_range-low = <fs_cif_ausp>-atinn.
    APPEND ls_atinn_range TO lt_atinn_range.
  ENDLOOP.

  SORT lt_atinn_range BY low.
  DELETE ADJACENT DUPLICATES FROM lt_atinn_range COMPARING low.
  mo_db_access->clse_select_cabn(
    CHANGING
      in_cabn = lt_atinn_range
      t_cabn  = lt_cif_cabn
  ).

  LOOP AT lt_cif_cabn ASSIGNING FIELD-SYMBOL(<fs_cif_cabn>).
    CHECK <fs_cif_cabn>-anzst > 30 ##NUMBER_OK.
    MESSAGE a245(xc) WITH <fs_cif_cabn>-atnam INTO dummy.
    IF ms_runtime_param-bal IS BOUND.
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
    RETURN.
  ENDLOOP.
  CLEAR: lt_atinn_range, lt_cif_cabn.

  " set queue name, queue type and operation mode
  IF ms_runtime_param-dlmod = if_drf_const=>mode_directly.
    " In direct replication mode, there should be only one product at a time
    READ TABLE lt_claf_inob_cif INDEX 1 ASSIGNING FIELD-SYMBOL(<ls_claf_inob_cif>).
    IF sy-subrc = 0.
      ls_rmclf-objek = <ls_claf_inob_cif>-objek_long.
    ELSE.
      " Ok, it does not have a corresponding INOB entry, try KSSK
      READ TABLE lt_claf_kssk_cif INDEX 1 ASSIGNING FIELD-SYMBOL(<ls_claf_kssk_cif>).
      IF sy-subrc = 0.
        ls_rmclf-objek = <ls_claf_kssk_cif>-objek_long.
      ENDIF.
    ENDIF.
    ASSERT ls_rmclf-objek IS NOT INITIAL.
    mo_db_access->clcv_convert_object_to_fields(
      EXPORTING
        iv_table     = if_ngc_drf_c=>gc_batch_mat_level_dbtable
      CHANGING
        cs_rmclfstru = ls_rmclf
        ev_subrc     = lv_subrc
    ).
    IF lv_subrc = 0.
      ls_ctrlparams-trfcchn = if_drf_ewm_out=>gc_queue_name_prefix && ls_rmclf-matnr(21).
    ELSE.
      IF ms_runtime_param-bal IS BOUND.
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
      RETURN.
    ENDIF.
  ELSE.
    ls_ctrlparams-trfcchn = if_drf_ewm_out=>gc_queue_name_prefix && if_drf_ewm_out=>gc_queue_name_inintial.
  ENDIF.
  ls_ctrlparams-queuetype = 'I'.
  ls_ctrlparams-opmode    = 'I'.

  " set trfc queue properties
  mo_ewm_util->rfc_trfc_set_qin_properties(
    EXPORTING
      iv_qin_name   = ls_ctrlparams-trfcchn
      iv_no_execute = lv_no_execute
    IMPORTING
      ev_subrc      = lv_subrc
  ).
  IF lv_subrc <> 0.
    IF ms_runtime_param-bal IS BOUND.
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

  " call APO CIF Classification FM
  mo_cif_functions->/sapapo/cif_claf_inb(
    EXPORTING
      iv_rfc_dest          = ms_runtime_param-rfcdest
      is_control_parameter = ls_ctrlparams
      iv_logsrcsys         = ls_ctrlparams-logsrcsys
    CHANGING
      ct_kssk              = lt_claf_kssk_cif
      ct_inob              = lt_claf_inob_cif
      ct_ausp              = lt_claf_ausp_cif
*     ct_allocation        =
*     ct_value             =
*     ct_delob             =
*     ct_extensionin       =
*     ct_atnam_source      =
*     ct_class_source      =
*     ct_matcfgs           =
      ct_return            = lt_ret ).

  IF ms_runtime_param-bal IS BOUND.
    ms_runtime_param-bal->add_msg_from_bapi( lt_ret ).
  ENDIF.

ENDMETHOD.