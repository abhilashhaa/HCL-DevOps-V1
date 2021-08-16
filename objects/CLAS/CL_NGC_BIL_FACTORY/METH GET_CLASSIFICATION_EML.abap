METHOD get_classification_eml.

  IF go_classification_eml IS INITIAL.
    go_classification_eml = NEW cl_ngc_bil_clf_eml( ).
  ENDIF.

  ro_classification_eml = go_classification_eml.

ENDMETHOD.