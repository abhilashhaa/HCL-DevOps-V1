METHOD if_drf_filter~apply_filter.

  CLEAR: et_filtered_objects.

  CHECK iv_outb_impl = if_ngc_drf_c=>gc_clsmas_drf_outb_impl.

  READ TABLE it_external_criteria WITH KEY tablename = is_filt-strucname ASSIGNING FIELD-SYMBOL(<ls_external_criteria>).
  IF sy-subrc EQ 0.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'KLART' ASSIGNING FIELD-SYMBOL(<ls_range_table>).
    IF sy-subrc EQ 0.
      DATA(lt_range_klart) = <ls_range_table>-selopt_t.
    ENDIF.
    READ TABLE <ls_external_criteria>-frange_t WITH KEY fieldname = 'CLASS' ASSIGNING <ls_range_table>.
    IF sy-subrc EQ 0.
      DATA(lt_range_class) = <ls_range_table>-selopt_t.
    ENDIF.
  ENDIF.

  mo_ngc_drf_util->get_selected_classes(
    EXPORTING
      it_range_klart = lt_range_klart
      it_range_class = lt_range_class
    IMPORTING
      et_cls_key     = DATA(lt_cls_key)
  ).

  et_filtered_objects = lt_cls_key.

ENDMETHOD.