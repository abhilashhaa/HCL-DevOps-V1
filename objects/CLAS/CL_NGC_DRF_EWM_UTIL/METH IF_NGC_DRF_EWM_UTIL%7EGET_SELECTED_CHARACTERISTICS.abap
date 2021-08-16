METHOD if_ngc_drf_ewm_util~get_selected_characteristics.

  CLEAR: et_chr_key.

  IF it_range_klart IS INITIAL AND it_range_class IS INITIAL.
    SELECT DISTINCT atnam
      FROM ( cabn INNER JOIN ksml ON ksml~imerk = cabn~atinn )
      WHERE cabn~atnam IS NOT INITIAL
        AND cabn~atnam IN @it_range_atnam
        AND ksml~ewm_rel = 'X'
        AND (iv_additional_where_cnd) "#EC CI_DYNWHERE
      INTO TABLE @et_chr_key.
  ELSE.
    SELECT DISTINCT cabn~atnam
      FROM ( klah INNER JOIN ksml ON klah~clint = ksml~clint INNER JOIN cabn ON ksml~imerk = cabn~atinn )
      WHERE cabn~atnam IS NOT INITIAL
        AND cabn~atnam IN @it_range_atnam
        AND ksml~ewm_rel = 'X'
        AND klah~klart IN @it_range_klart
        AND klah~class IN @it_range_class
        AND (iv_additional_where_cnd) "#EC CI_DYNWHERE
      INTO TABLE @et_chr_key.
  ENDIF.

ENDMETHOD.