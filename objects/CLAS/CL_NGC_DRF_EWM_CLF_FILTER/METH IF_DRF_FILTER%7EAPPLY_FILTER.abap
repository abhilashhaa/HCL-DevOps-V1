METHOD if_drf_filter~apply_filter.

  DATA:
    lt_range_class      TYPE rsdsselopt_t,
    lt_range_matnr      TYPE rsdsselopt_t,
    lt_range_lgnum      TYPE rsdsselopt_t,
    lv_object_filter    TYPE string,
    lt_filtered_objects TYPE if_ngc_drf_ewm_util=>ty_t_clf_batch_key.

  FIELD-SYMBOLS:
    <et_filtered_clfmas_objects>   TYPE ngct_drf_clfmas_object_key.

  CLEAR: et_filtered_objects.

  CHECK iv_outb_impl = if_ngc_drf_c=>gc_clf_ewm_drf_outb_impl.

  IF it_unfiltered_objects IS NOT INITIAL.
    TRY.
      ASSIGN it_unfiltered_objects TO FIELD-SYMBOL(<it_unfiltered_clfmas_objects>) CASTING TYPE ngct_drf_clfmas_object_key.
    CATCH cx_sy_assign_cast_illegal_cast.
      " It seeems it_unfiltered_objects is not ngct_drf_clfmas_object_key, so there is nothing we can do
      ASSERT 0 = 1.
    ENDTRY.
    lv_object_filter = mo_ngc_drf_ewm_util->get_object_filter(
                         it_unfiltered_objects = <it_unfiltered_clfmas_objects>
                         it_field_names        = VALUE #( ( key_filter_field_name = 'object_table'   ##NO_TEXT
                                                            check_against_name    = 'inob~obtab' )   ##NO_TEXT
                                                          ( key_filter_field_name = 'klart'          ##NO_TEXT
                                                            check_against_name    = 'tcla~klart' )   ##NO_TEXT
                                                          ( key_filter_field_name = 'objkey'         ##NO_TEXT
                                                            check_against_name    = 'inob~cuobj' ) ) ##NO_TEXT
    ).
  ENDIF.

  READ TABLE it_external_criteria WITH KEY tablename = is_filt-strucname ASSIGNING FIELD-SYMBOL(<ls_external_criteria>).
  IF sy-subrc EQ 0.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'CLASS' ASSIGNING FIELD-SYMBOL(<ls_range_table_cls>).
    IF sy-subrc EQ 0.
      lt_range_class = <ls_range_table_cls>-selopt_t.
    ENDIF.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'MATNR' ASSIGNING FIELD-SYMBOL(<ls_range_table_matnr>).
    IF sy-subrc EQ 0.
      lt_range_matnr = <ls_range_table_matnr>-selopt_t.
    ENDIF.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'LGNUM' ASSIGNING FIELD-SYMBOL(<ls_range_table_lgnum>).
    IF sy-subrc EQ 0.
      lt_range_lgnum = <ls_range_table_lgnum>-selopt_t.
    ENDIF.
  ENDIF.

  " Read in the keys from the DB, using the filtering criterias
  mo_ngc_drf_ewm_util->get_selected_classifications(
    EXPORTING
      it_range_klart          = VALUE #( ( sign = 'I' option = 'EQ' low = if_ngc_drf_c=>gc_batch_classtype_mat_level ) )
      it_range_obtab          = VALUE #( ( sign = 'I' option = 'EQ' low = if_ngc_drf_c=>gc_batch_mat_level_dbtable ) )
      it_range_class          = lt_range_class
      it_range_matnr          = lt_range_matnr
      it_range_lgnum          = lt_range_lgnum
      iv_additional_where_cnd = lv_object_filter
    IMPORTING
      et_clf_key              = lt_filtered_objects
  ).

  " Now remove entries where the batch is not yet sent out
  drop_objects_if_no_batch_repli(
    EXPORTING
      iv_dlmod           = iv_dlmod
      iv_business_system = iv_business_system
    CHANGING
      ct_object          = lt_filtered_objects
  ).

  ASSIGN et_filtered_objects TO <et_filtered_clfmas_objects>.
  MOVE-CORRESPONDING lt_filtered_objects TO <et_filtered_clfmas_objects>.
ENDMETHOD.