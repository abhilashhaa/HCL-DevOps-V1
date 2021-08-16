METHOD SELECT_FROM_TCLA.

  CLEAR: et_tcla.

  READ TABLE it_selection_criteria ASSIGNING FIELD-SYMBOL(<ls_selection_criteria>)
    WITH KEY tablename = 'KSSK'.
  IF sy-subrc = 0.
    READ TABLE <ls_selection_criteria>-frange_t ASSIGNING FIELD-SYMBOL(<ls_frange_t>)
      WITH KEY fieldname = 'KSSK~KLART'.
  ENDIF.

  IF <ls_frange_t> IS ASSIGNED AND <ls_frange_t>-selopt_t IS NOT INITIAL.
    TEST-SEAM select_tcla_range.
      SELECT klart obtab multobj FROM tcla INTO CORRESPONDING FIELDS OF TABLE et_tcla WHERE klart IN <ls_frange_t>-selopt_t ##TOO_MANY_ITAB_FIELDS.
    END-TEST-SEAM.
  ELSE.
    TEST-SEAM select_tcla.
      SELECT klart obtab multobj FROM tcla INTO CORRESPONDING FIELDS OF TABLE et_tcla ##TOO_MANY_ITAB_FIELDS.
    END-TEST-SEAM.
  ENDIF.

ENDMETHOD.