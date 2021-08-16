METHOD convert_msg_corecls_to_coreclf.

  CLEAR: et_core_classification_msg.


  LOOP AT it_core_class_msg ASSIGNING FIELD-SYMBOL(<ls_core_class_msg>).
    APPEND INITIAL LINE TO et_core_classification_msg ASSIGNING FIELD-SYMBOL(<ls_core_classification_msg>).
    MOVE-CORRESPONDING <ls_core_class_msg> TO <ls_core_classification_msg>.
    MOVE-CORRESPONDING is_classification_key TO <ls_core_classification_msg>.
  ENDLOOP.

ENDMETHOD.