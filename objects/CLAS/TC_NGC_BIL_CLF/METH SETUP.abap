  METHOD setup.

    DATA:
      lo_clf_api_result     TYPE REF TO cl_ngc_clf_api_result,
      lo_ngc_characteristic TYPE REF TO if_ngc_characteristic.

    mo_ngc_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    DO 5 TIMES.
      lo_ngc_characteristic ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).
      APPEND VALUE #(
        charcinternalid       = th_ngc_bil_clf_data=>gt_objectcharcval_delete_multi[ sy-index ]-charcinternalid
        characteristic_object = lo_ngc_characteristic )
        TO mt_ngc_characteristic.
    ENDDO.

    mo_ngc_characteristic ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).

    mo_ngc_api            ?= cl_abap_testdouble=>create( 'if_ngc_api' ).

    cl_rap_plmi_msg_convert=>get_mapper(
      IMPORTING
        eo_mapper_symsg = DATA(lo_sy_msg_convert) ).

    mo_cut = NEW cl_ngc_bil_clf(
      io_ngc_api        = mo_ngc_api
      io_sy_msg_convert = lo_sy_msg_convert ).

    DO 5 TIMES.
      APPEND VALUE #( classification = mo_ngc_classification ) TO mt_ngc_classification_obj.
    ENDDO.

  ENDMETHOD.