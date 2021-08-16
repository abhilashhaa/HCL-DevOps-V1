METHOD convert_msg_corechr_to_clf.

  FIELD-SYMBOLS:
    <ls_clf_characteristic_key> TYPE ngcs_clf_characteristic_key.

  CLEAR: et_classification_msg.

  LOOP AT it_core_charc_msg ASSIGNING FIELD-SYMBOL(<ls_core_charc_msg>).
    APPEND INITIAL LINE TO et_classification_msg ASSIGNING FIELD-SYMBOL(<ls_classification_msg>).
    MOVE-CORRESPONDING is_classification_key TO <ls_classification_msg>.
    MOVE-CORRESPONDING <ls_core_charc_msg> TO <ls_classification_msg>.
    IF is_clf_characteristic_key IS SUPPLIED.
      <ls_classification_msg>-ref_type = 'NGCS_CLF_CHARACTERISTIC_KEY'.
      CREATE DATA <ls_classification_msg>-ref_key TYPE ngcs_clf_characteristic_key.
      ASSIGN <ls_classification_msg>-ref_key->* TO <ls_clf_characteristic_key>.
      <ls_clf_characteristic_key>-classtype       = is_clf_characteristic_key-classtype.
      <ls_clf_characteristic_key>-charcinternalid = is_clf_characteristic_key-charcinternalid.
      <ls_clf_characteristic_key>-key_date        = is_clf_characteristic_key-key_date.
    ENDIF.
  ENDLOOP.

ENDMETHOD.