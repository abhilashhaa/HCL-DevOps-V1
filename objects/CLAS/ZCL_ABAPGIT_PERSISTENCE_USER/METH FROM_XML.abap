  METHOD from_xml.

    DATA: lv_xml TYPE string.

    lv_xml = iv_xml.

* fix downward compatibility
    REPLACE ALL OCCURRENCES OF '<_--28C_TYPE_USER_--29>' IN lv_xml WITH '<USER>'.
    REPLACE ALL OCCURRENCES OF '</_--28C_TYPE_USER_--29>' IN lv_xml WITH '</USER>'.

    CALL TRANSFORMATION id
      OPTIONS value_handling = 'accept_data_loss'
      SOURCE XML lv_xml
      RESULT user = rs_user.
  ENDMETHOD.