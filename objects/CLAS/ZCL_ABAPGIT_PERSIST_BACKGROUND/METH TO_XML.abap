  METHOD to_xml.
    DATA: ls_xml TYPE ty_xml.

    MOVE-CORRESPONDING is_background TO ls_xml.

    CALL TRANSFORMATION id
      SOURCE data = ls_xml
      RESULT XML rv_string.
  ENDMETHOD.