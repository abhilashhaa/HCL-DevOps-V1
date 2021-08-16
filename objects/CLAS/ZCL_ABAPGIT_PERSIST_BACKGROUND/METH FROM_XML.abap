  METHOD from_xml.
    CALL TRANSFORMATION id
      OPTIONS value_handling = 'accept_data_loss'
      SOURCE XML iv_string
      RESULT data = rs_xml.
  ENDMETHOD.