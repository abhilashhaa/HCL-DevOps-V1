  METHOD reset.
    DELETE mt_stage WHERE file-path = iv_path AND file-filename = iv_filename.
    ASSERT sy-subrc = 0.
  ENDMETHOD.