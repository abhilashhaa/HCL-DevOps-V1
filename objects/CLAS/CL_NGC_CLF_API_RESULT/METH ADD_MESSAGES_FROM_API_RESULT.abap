METHOD add_messages_from_api_result.

  IF io_clf_api_result IS BOUND.
    APPEND LINES OF io_clf_api_result->get_messages( ) TO mt_message.
  ENDIF.

ENDMETHOD.