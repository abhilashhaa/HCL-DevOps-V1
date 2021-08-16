METHOD if_ngc_drf_ewm_util~cif_mfle_set_buf.
  cl_mfle_cif_clcg_mapper=>set_buf(
    EXPORTING
      it_table = it_table
  ).
ENDMETHOD.