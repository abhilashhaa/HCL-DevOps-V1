METHOD calculate_intersection.

  READ TABLE mt_characteristic_data ASSIGNING FIELD-SYMBOL(<ls_characteristics_data>)
    WITH KEY charcinternalid = is_clfnclasshiercharcforkeydat-charcinternalid
             key_date        = is_clfnclasshiercharcforkeydat-key_date.
  ASSERT sy-subrc = 0.

  mo_util_intersect->calculate_intersection(
    EXPORTING
      iv_charcdatatype         = <ls_characteristics_data>-charcdatatype
      it_collected_char_values = it_collected_char_values
    IMPORTING
      es_collected_char_value  = es_collected_char_value
  ).

ENDMETHOD.