METHOD get_classification_util.

  IF go_classification_util IS INITIAL.
    go_classification_util = NEW cl_ngc_bil_clf_util( ).
  ENDIF.

  ro_classification_util = go_classification_util.

ENDMETHOD.