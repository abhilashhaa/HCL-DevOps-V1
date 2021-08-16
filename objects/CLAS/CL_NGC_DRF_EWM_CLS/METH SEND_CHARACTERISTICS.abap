METHOD send_characteristics.

  DATA:
*   lt_atinn_range            TYPE tt_atinn_range,
    lt_cabn                   TYPE tt_cabn,
    lt_cabnt                  TYPE tt_cabnt,
    lt_cawn                   TYPE tt_cawn,
    lt_cawnt                  TYPE tt_cawnt,
    lt_cabnz                  TYPE tt_cabnz,
    lt_tcme                   TYPE tt_tcme,
    lt_atinn                  TYPE if_ngc_drf_util=>tt_atinn.

  LOOP AT it_ksml ASSIGNING FIELD-SYMBOL(<is_ksml>).
*    APPEND VALUE #( sign   = 'I'
*                    option = 'EQ'
*                    low    = ls_ksml-imerk ) TO lt_atinn_range.
    APPEND <is_ksml>-imerk TO lt_atinn.
  ENDLOOP.

*  IF NOT lt_atinn_range[] IS INITIAL.

*  mo_db_access->clidl_read_masterdata(
*    EXPORTING
*      with_hierarchies = space
*    IMPORTING
*      ev_subrc         = DATA(lv_subrc)
*    CHANGING
*      it_atinn_range   = lt_atinn_range
*      et_cabn          = lt_cabn
*      et_cabnt         = lt_cabnt
*      et_cawn          = lt_cawn
*      et_cawnt         = lt_cawnt
*      et_cabnz         = lt_cabnz
*      et_tcme          = lt_tcme
*  ).
*  IF lv_subrc <> 0.
*    ms_runtime_param-bal->add_msg(
*      iv_msgty = sy-msgty
*      iv_msgno = sy-msgno
*      iv_msgid = sy-msgid
*      iv_msgv1 = sy-msgv1
*      iv_msgv2 = sy-msgv2
*      iv_msgv3 = sy-msgv3
*      iv_msgv4 = sy-msgv4
*    ).
*  ENDIF.

  IF lt_atinn IS NOT INITIAL.

    mo_ngc_drf_util->get_characteristic_data(
      EXPORTING
        it_atinn             = lt_atinn
      IMPORTING
        et_charact_tab       = lt_cabn
        et_charact_descr_tab = lt_cabnt
        et_value_tab         = lt_cawn
        et_value_descr_tab   = lt_cawnt
        et_restrictions_tab  = lt_tcme
        et_references_tab    = lt_cabnz
    ).

    mo_ewm_util->change_classtype_tcme(
      EXPORTING
        iv_class_type_from = if_ngc_drf_c=>gc_batch_classtype_mat_level
        iv_class_type_to   = if_ngc_drf_c=>gc_ewm_classtype_version
      CHANGING
        ct_tcme            = lt_tcme
        cs_ctrlparams      = cs_ctrlparams
    ).

    mo_ewm_util->apo_irrelevant_tcme(
      CHANGING
        ct_tcme       = lt_tcme
        cs_ctrlparams = cs_ctrlparams
    ).

    mo_ewm_util->expand_tcme_for_cdp(
      CHANGING
        ct_tcme       = lt_tcme
        cs_ctrlparams = cs_ctrlparams
    ).

    cl_ngc_drf_ewm_chr=>send_cif_characteristic(
      EXPORTING
        is_runtime_param    = ms_runtime_param
        io_ngc_drf_ewm_util = mo_ewm_util
        it_cabn             = lt_cabn
        it_cabnt            = lt_cabnt
        it_cawn             = lt_cawn
        it_cawnt            = lt_cawnt
        it_cabnz            = lt_cabnz
        it_tcme             = lt_tcme
      CHANGING
        ct_obj_rep_sta      = ct_obj_rep_sta
    ).

  ENDIF.

ENDMETHOD.