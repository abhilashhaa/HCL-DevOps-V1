METHOD if_drf_filter~apply_filter.

  CLEAR: et_filtered_objects.

  CHECK iv_outb_impl = if_ngc_drf_c=>gc_chrmas_drf_outb_impl.

  READ TABLE it_external_criteria WITH KEY tablename = is_filt-strucname ASSIGNING FIELD-SYMBOL(<ls_external_criteria>).
  IF sy-subrc EQ 0.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'ATNAM' ASSIGNING FIELD-SYMBOL(<ls_range_table>).
    IF sy-subrc EQ 0.
      DATA(lt_range_atnam) = <ls_range_table>-selopt_t.
    ENDIF.
  ENDIF.

  mo_ngc_drf_util->get_selected_characteristics(
    EXPORTING
      it_range_atnam = lt_range_atnam
    IMPORTING
      et_chr_key     = DATA(lt_chr_key)
  ).

  et_filtered_objects = lt_chr_key.

ENDMETHOD.