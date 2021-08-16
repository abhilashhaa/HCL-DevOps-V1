  METHOD GET_VALUATION_DATA.

    rt_valuation_data = VALUE #( (
      th_ngc_bil_clf_data=>gt_objectcharcval_val_data_mul[
        charcinternalid = th_ngc_bil_clf_data=>gt_objectcharcval_charc_header[
          charcdatatype = iv_charcdatatype
      ]-charcinternalid ]
    ) ).

  ENDMETHOD.