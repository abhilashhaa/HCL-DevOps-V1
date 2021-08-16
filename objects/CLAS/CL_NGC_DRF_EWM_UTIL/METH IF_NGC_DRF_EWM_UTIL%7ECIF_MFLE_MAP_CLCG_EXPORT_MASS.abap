METHOD if_ngc_drf_ewm_util~cif_mfle_map_clcg_export_mass.
  CLEAR: et_table.

  cl_mfle_cif_clcg_mapper=>map_clcg_export_mass(
    EXPORTING
      is_matnr_fieldnames = is_matnr_fieldnames
      it_table            = it_table
      is_cuobn_fieldnames = is_cuobn_fieldnames
      it_char_fieldnames  = it_char_fieldnames
      it_cux_fieldnames   = it_cux_fieldnames
    IMPORTING
      et_table            = et_table
  ).
ENDMETHOD.