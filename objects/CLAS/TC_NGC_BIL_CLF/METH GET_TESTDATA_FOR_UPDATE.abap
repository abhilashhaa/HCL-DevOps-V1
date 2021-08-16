  METHOD GET_TESTDATA_FOR_UPDATE.

    rt_objectcharcval_update = VALUE #( (
      th_ngc_bil_clf_data=>gt_objectcharcval_update[
        charcinternalid = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[
          charcdatatype = iv_charcdatatype
      ]-charcinternalid ]
    ) ).

  ENDMETHOD.