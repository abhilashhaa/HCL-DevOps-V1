METHOD if_ngc_drf_util~get_selected_classes.

  SELECT DISTINCT klart class FROM klah INTO CORRESPONDING FIELDS OF TABLE et_cls_key
    WHERE klart IN it_range_klart
      AND class IN it_range_class
      AND (iv_additional_where_cnd). "#EC CI_DYNWHERE

  DELETE et_cls_key WHERE klart IS INITIAL OR class IS INITIAL.

ENDMETHOD.