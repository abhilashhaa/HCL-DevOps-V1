METHOD get_selected_classifications.

  DATA:
    lt_clf_key        TYPE ngct_drf_clfmas_object_key,
    lt_tcla           TYPE STANDARD TABLE OF tcla,
    lt_classification TYPE STANDARD TABLE OF ty_s_classification,
    lv_where          TYPE boole_d VALUE abap_false,
    lt_where          TYPE rsds_where_tab,
    lv_new_crit       TYPE boole_d VALUE abap_false.

  CLEAR: et_clf_key.

  READ TABLE it_where_condition INTO DATA(ls_where)
    WITH KEY tablename = 'KSSK'.
  IF sy-subrc = 0.
    READ TABLE ls_where-where_tab INTO DATA(ls_where_tab) INDEX 1.
    IF sy-subrc = 0 AND
       ls_where_tab IS NOT INITIAL.
      lv_where = abap_true.
    ENDIF.
  ENDIF.

  LOOP AT it_where_condition INTO ls_where.
    IF sy-tabix > 1.
      lv_new_crit = abap_true.
    ENDIF.
    LOOP AT ls_where-where_tab INTO ls_where_tab.
      IF lv_new_crit = abap_true.
        CONCATENATE 'AND' ls_where_tab-line INTO ls_where_tab-line SEPARATED BY space.
        lv_new_crit = abap_false.
      ENDIF.
      APPEND ls_where_tab TO lt_where.
    ENDLOOP.
  ENDLOOP.

  select_from_tcla(
    EXPORTING
      it_selection_criteria = it_selection_criteria
    IMPORTING
      et_tcla               = lt_tcla
  ).

  select_from_kssk(
    EXPORTING
      it_tcla           = lt_tcla
      iv_where          = lv_where
      it_where          = lt_where
    IMPORTING
      et_classification = lt_classification
  ).

  LOOP AT lt_classification ASSIGNING FIELD-SYMBOL(<ls_classification>).
    INSERT VALUE #( object_table = <ls_classification>-obtab
                    klart        = <ls_classification>-klart
                    objkey       = <ls_classification>-objek ) INTO TABLE lt_clf_key ##LOOP_INDEX.
  ENDLOOP.

  et_clf_key = lt_clf_key.

ENDMETHOD.