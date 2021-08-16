  METHOD if_ngc_bil_clf_eml~exec_obj_setrefdata.

    CLEAR: es_failed, es_reported.

    MODIFY ENTITY i_clfnobjecttp
      EXECUTE setrefdata
        FROM it_input
          FAILED   es_failed
          REPORTED es_reported.

  ENDMETHOD.