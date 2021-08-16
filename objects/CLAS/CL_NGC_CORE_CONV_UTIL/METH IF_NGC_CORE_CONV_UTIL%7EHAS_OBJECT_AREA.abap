  METHOD if_ngc_core_conv_util~has_object_area.

    CALL FUNCTION 'CTMS_DDB_HAS_OBJECT_AREA'
        TABLES
          objects = rt_object_area.

  ENDMETHOD.