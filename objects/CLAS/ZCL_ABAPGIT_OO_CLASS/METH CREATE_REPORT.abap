  METHOD create_report.
    INSERT REPORT iv_program FROM it_source EXTENSION TYPE iv_extension STATE iv_version PROGRAM TYPE iv_program_type.
    ASSERT sy-subrc = 0.
  ENDMETHOD.