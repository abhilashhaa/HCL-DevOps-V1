METHOD overwrite_field.
  rv_field = COND #( WHEN iv_overwritten_field = if_ngc_core_c=>gc_charc_overwrite_ref_ind THEN iv_original_field
                                                                                           ELSE iv_overwritten_field ).
ENDMETHOD.