METHOD if_drf_filter~apply_filter.

  DATA:
    lt_range_atnam   TYPE rsdsselopt_t,
    lt_range_class   TYPE rsdsselopt_t,
    lv_object_filter TYPE string.

  CLEAR: et_filtered_objects.

  CHECK iv_outb_impl = if_ngc_drf_c=>gc_chr_ewm_drf_outb_impl.

  IF it_unfiltered_objects IS NOT INITIAL.
    TRY.
      ASSIGN it_unfiltered_objects TO FIELD-SYMBOL(<it_unfiltered_chrmas_objects>) CASTING TYPE ngct_drf_chrmas_object_key.
    CATCH cx_sy_assign_cast_illegal_cast.
      " It seeems it_unfiltered_objects is not ngct_drf_chrmas_object_key, so there is nothing we can do
      ASSERT 0 = 1.
    ENDTRY.
    lv_object_filter = mo_ngc_drf_ewm_util->get_object_filter(
                         it_unfiltered_objects = <it_unfiltered_chrmas_objects>
                         it_field_names        = VALUE #( ( key_filter_field_name = 'atnam' ##NO_TEXT
                                                            check_against_name    = 'cabn~atnam' ) ) ##NO_TEXT
    ).
  ENDIF.

  READ TABLE it_external_criteria WITH KEY tablename = is_filt-strucname ASSIGNING FIELD-SYMBOL(<ls_external_criteria>).
  IF sy-subrc EQ 0.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'ATNAM' ASSIGNING FIELD-SYMBOL(<ls_range_table>).
    IF sy-subrc EQ 0.
      lt_range_atnam = <ls_range_table>-selopt_t.
    ENDIF.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'CLASS' ASSIGNING FIELD-SYMBOL(<ls_range_table_cls>).
    IF sy-subrc EQ 0.
      lt_range_class = <ls_range_table_cls>-selopt_t.
    ENDIF.
  ENDIF.

  mo_ngc_drf_ewm_util->get_selected_characteristics(
    EXPORTING
      it_range_atnam          = lt_range_atnam
      it_range_klart          = VALUE #( ( sign = 'I' option = 'EQ' low = if_ngc_drf_c=>gc_batch_classtype_mat_level ) )
      it_range_class          = lt_range_class
      iv_additional_where_cnd = lv_object_filter
    IMPORTING
      et_chr_key              = et_filtered_objects
  ).

ENDMETHOD.