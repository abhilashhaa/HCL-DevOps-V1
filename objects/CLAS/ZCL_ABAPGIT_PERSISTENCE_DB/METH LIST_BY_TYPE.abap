  METHOD list_by_type.
    SELECT * FROM (c_tabname)
      INTO TABLE rt_content
      WHERE type = iv_type
      ORDER BY PRIMARY KEY.                               "#EC CI_SUBRC
  ENDMETHOD.