METHOD if_drf_filter~apply_filter.

  DATA:
    lt_ext_criteria   TYPE rsds_trange,
    ls_ext_criteria   TYPE rsds_range,
    lt_filter_range   TYPE rsds_frange_t,
    ls_filter_range   TYPE rsds_frange,
    lt_seloption      TYPE rsds_selopt_t,
    lv_ext_crit_exist TYPE abap_bool VALUE abap_false.

  FIELD-SYMBOLS:
    <ls_ext_criteria> TYPE rsds_range,
    <ls_filter_range> TYPE rsds_frange.

  CLEAR: et_filtered_objects.

  CHECK iv_outb_impl = if_ngc_drf_c=>gc_clfmas_drf_outb_impl.

  LOOP AT it_external_criteria ASSIGNING <ls_ext_criteria>.

    LOOP AT <ls_ext_criteria>-frange_t ASSIGNING <ls_filter_range>.
      CASE <ls_filter_range>-fieldname.
        WHEN 'KLART'.
          CLEAR: ls_ext_criteria.
          ls_ext_criteria-tablename = 'KSSK'.
          MOVE-CORRESPONDING <ls_filter_range> TO ls_filter_range.
          ls_filter_range-fieldname = 'KSSK~KLART'.
          APPEND ls_filter_range TO lt_filter_range.
          ls_ext_criteria-frange_t = lt_filter_range.
          APPEND ls_ext_criteria TO lt_ext_criteria.
          lv_ext_crit_exist = abap_true.
      ENDCASE.
      CLEAR lt_filter_range.
    ENDLOOP.

  ENDLOOP.  " it_external_criteria

  IF lv_ext_crit_exist = abap_false AND it_unfiltered_objects IS INITIAL.
    ls_ext_criteria-tablename = 'KSSK'.
    ls_filter_range-fieldname = 'KSSK~KLART'.
    INSERT VALUE #( sign = 'I' option = 'CP' low = '*' ) INTO TABLE lt_seloption.
    ls_filter_range-selopt_t = lt_seloption.
    APPEND ls_filter_range TO lt_filter_range.
    ls_ext_criteria-frange_t = lt_filter_range.
    APPEND ls_ext_criteria TO lt_ext_criteria.
  ENDIF.

  mo_ngc_drf_util->get_selected_classifications(
    EXPORTING
      it_selection_criteria = lt_ext_criteria
    IMPORTING
      et_clf_key            = DATA(lt_clf_key) ).

  et_filtered_objects = lt_clf_key.

ENDMETHOD.