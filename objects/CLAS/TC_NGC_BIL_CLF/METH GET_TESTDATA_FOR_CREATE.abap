  METHOD get_testdata_for_create.

    rt_objectcharcval_create = VALUE #( (
      th_ngc_bil_clf_data=>gt_objectcharcval_create[
        charcinternalid = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[
          charcdatatype = iv_charcdatatype
      ]-charcinternalid ]
    ) ).

  ENDMETHOD.