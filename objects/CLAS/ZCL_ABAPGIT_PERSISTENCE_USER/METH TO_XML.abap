  METHOD to_xml.
    CALL TRANSFORMATION id
      SOURCE user = is_user
      RESULT XML rv_xml.
  ENDMETHOD.