METHOD if_ngc_drf_ewm_util~get_selected_classes.

  SELECT DISTINCT klah~klart klah~class
    FROM ( klah INNER JOIN ksml ON klah~clint = ksml~clint )
    INTO CORRESPONDING FIELDS OF TABLE et_cls_key
    WHERE klah~klart IN it_range_klart
      AND klah~class IN it_range_class
      AND ksml~ewm_rel = 'X'
      AND (iv_additional_where_cnd). "#EC CI_DYNWHERE

  DELETE et_cls_key WHERE klart IS INITIAL OR class IS INITIAL.

ENDMETHOD.