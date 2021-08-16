  METHOD zif_abapgit_object~exists.

    DATA: lv_object_type TYPE trobjtype,
          lv_object_name TYPE trobj_name.

    lv_object_type = ms_item-obj_type.
    lv_object_name = ms_item-obj_name.

    CALL FUNCTION 'SOTR_WBO_OBJECTS_CHECK'
      EXPORTING
        pgmid          = 'R3TR'
        object         = lv_object_type
        obj_name       = lv_object_name
      IMPORTING
        object_exist   = rv_bool
      EXCEPTIONS
        unknown_object = 1
        OTHERS         = 2.

    IF sy-subrc <> 0.
      rv_bool = abap_false.
    ENDIF.

  ENDMETHOD.