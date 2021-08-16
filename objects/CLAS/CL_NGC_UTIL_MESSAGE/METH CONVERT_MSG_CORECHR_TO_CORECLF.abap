METHOD convert_msg_corechr_to_coreclf.

  CLEAR: et_core_classification_msg.

  LOOP AT it_core_charc_msg ASSIGNING FIELD-SYMBOL(<ls_core_charc_msg>).
    APPEND INITIAL LINE TO et_core_classification_msg ASSIGNING FIELD-SYMBOL(<ls_core_classification_msg>).
    MOVE-CORRESPONDING <ls_core_charc_msg> TO <ls_core_classification_msg>.
    MOVE-CORRESPONDING is_classification_key TO <ls_core_classification_msg>.
  ENDLOOP.

ENDMETHOD.