  METHOD if_ngc_rap_cls_bapi_util~delete_class_api.

    CLEAR: rt_return.

    CALL FUNCTION 'BAPI_CLASS_DELETE'
      EXPORTING
        classtype = iv_classtype
        classnum  = iv_class
      TABLES
        return    = rt_return.

  ENDMETHOD.