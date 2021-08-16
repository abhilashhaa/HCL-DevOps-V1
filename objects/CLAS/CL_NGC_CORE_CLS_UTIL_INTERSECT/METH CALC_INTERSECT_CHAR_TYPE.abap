METHOD calc_intersect_char_type.

  CLEAR: es_collected_char_value.

  CHECK it_collected_char_values IS NOT INITIAL.

  READ TABLE it_collected_char_values ASSIGNING FIELD-SYMBOL(<ls_collected_char_value>) INDEX 1.
  es_collected_char_value = <ls_collected_char_value>.

  LOOP AT it_collected_char_values ASSIGNING <ls_collected_char_value> FROM 2.
    LOOP AT es_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_charc_value_intersect>).
      DATA(lv_index) = sy-tabix.
      READ TABLE <ls_collected_char_value>-charc_values TRANSPORTING NO FIELDS WITH KEY charcvalue = <ls_charc_value_intersect>-charcvalue.
      IF sy-subrc <> 0.
        DELETE es_collected_char_value-charc_values INDEX lv_index.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.