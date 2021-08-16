  METHOD escape_message.

    rv_string = iv_string.

    REPLACE ALL OCCURRENCES OF '\' IN rv_string WITH '\\'.
    REPLACE ALL OCCURRENCES OF '"' IN rv_string WITH '\"'.

  ENDMETHOD.