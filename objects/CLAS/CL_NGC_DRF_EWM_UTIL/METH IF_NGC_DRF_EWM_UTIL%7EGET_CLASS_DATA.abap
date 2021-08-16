METHOD if_ngc_drf_ewm_util~get_class_data.

  CLEAR: et_class_header, et_charact_tab, et_catchword_tab.

  IF lines( it_bo_key ) > 0.
    SELECT *
      FROM klah
      FOR ALL ENTRIES IN @it_bo_key
      WHERE klah~klart = @it_bo_key-klart AND klah~class = @it_bo_key-class
      INTO TABLE @et_class_header.

    " At this point, we assume a consistent DB, so every swor row should have a corresponding row in klah
    " But we filter out incosistent swor entries, which do not have a corresponding klah entry
    SELECT swor~*
      FROM ( swor INNER JOIN klah ON swor~clint = klah~clint )
      FOR ALL ENTRIES IN @it_bo_key
      WHERE klah~klart = @it_bo_key-klart AND klah~class = @it_bo_key-class
      INTO TABLE @et_catchword_tab.

    " At this point, we assume a consistent DB, so every ksml row should have a corresponding row in klah
    " But we filter out incosistent ksml entries, which do not have a corresponding klah entry
    SELECT ksml~*
      FROM ( ksml INNER JOIN klah ON ksml~clint = klah~clint )
      FOR ALL ENTRIES IN @it_bo_key
      WHERE klah~klart = @it_bo_key-klart AND klah~class = @it_bo_key-class AND ksml~ewm_rel = 'X'
      INTO TABLE @et_charact_tab.
  ENDIF.

ENDMETHOD.