  METHOD corr_insert.

    DATA: lv_object       TYPE string,
          lv_object_class TYPE string.

    IF ig_object_class IS NOT INITIAL.
      lv_object_class = ig_object_class.
      IF ig_object_class = 'DICT'.
        CONCATENATE ms_item-obj_type ms_item-obj_name INTO lv_object.
      ELSE.
        lv_object = ms_item-obj_name.
      ENDIF.
    ELSE.
      lv_object_class = ms_item-obj_type.
      lv_object       = ms_item-obj_name.
    ENDIF.

    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        object              = lv_object
        object_class        = lv_object_class
        devclass            = iv_package
        master_language     = mv_language
        global_lock         = abap_true
        mode                = 'I'
        suppress_dialog     = abap_true
      EXCEPTIONS
        cancelled           = 1
        permission_failure  = 2
        unknown_objectclass = 3
        OTHERS              = 4.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.