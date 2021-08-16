METHOD if_drf_outbound~send_message.

  DATA:
    lt_relevant_objects TYPE ngct_drf_clsmas_object_key.

  CLEAR: et_file_data, et_message.

  APPEND LINES OF mt_relevant_objects
    FROM mv_processed_relobj_num + 1 TO mv_processed_relobj_num + iv_object_count
    TO lt_relevant_objects.

  send_cif_class(
    EXPORTING
      it_relevant_objects = lt_relevant_objects
    CHANGING
      ct_obj_rep_sta      = ct_obj_rep_sta
  ).

  " This package is processed, so:
  ADD iv_object_count TO mv_processed_relobj_num.

ENDMETHOD.