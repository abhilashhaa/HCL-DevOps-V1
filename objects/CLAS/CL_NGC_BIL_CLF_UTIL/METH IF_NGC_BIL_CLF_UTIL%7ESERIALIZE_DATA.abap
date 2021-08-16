METHOD if_ngc_bil_clf_util~serialize_data.

  CALL TRANSFORMATION id
    SOURCE ref = is_data
    RESULT XML rv_data_binary.

ENDMETHOD.