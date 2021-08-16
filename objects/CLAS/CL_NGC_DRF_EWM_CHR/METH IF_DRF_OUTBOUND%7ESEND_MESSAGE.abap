METHOD if_drf_outbound~send_message.

  DATA:
    lt_relevant_objects TYPE ngct_drf_chrmas_object_key.

  CLEAR: et_file_data, et_message.

  APPEND LINES OF mt_relevant_objects
    FROM mv_processed_relobj_num + 1 TO mv_processed_relobj_num + iv_object_count
    TO lt_relevant_objects.

  mo_ngc_drf_util->get_characteristic_data(
    EXPORTING
      it_bo_keys           = lt_relevant_objects
    IMPORTING
      et_charact_tab       = DATA(lt_cabn)
      et_charact_descr_tab = DATA(lt_cabnt)
      et_value_tab         = DATA(lt_cawn)
      et_value_descr_tab   = DATA(lt_cawnt)
      et_restrictions_tab  = DATA(lt_tcme)
      et_references_tab    = DATA(lt_cabnz)
  ).

  send_cif_characteristic(
    EXPORTING
      is_runtime_param     = ms_runtime_param
      io_ngc_drf_ewm_util  = mo_ewm_util
      it_cabn              = lt_cabn
      it_cabnt             = lt_cabnt
      it_cawn              = lt_cawn
      it_cawnt             = lt_cawnt
      it_cabnz             = lt_cabnz
      it_tcme              = lt_tcme
    CHANGING
      ct_obj_rep_sta       = ct_obj_rep_sta
  ).

  " This package is processed, so:
  ADD iv_object_count TO mv_processed_relobj_num.

ENDMETHOD.