  METHOD zif_abapgit_object~jump.

    DATA: lv_objectname TYPE tdct-dnam.

    lv_objectname = ms_item-obj_name.

    CALL FUNCTION 'RS_DIALOG_SHOW'
      EXPORTING
        objectname       = lv_objectname
        type             = 'VW'
      EXCEPTIONS
        object_not_found = 1
        OTHERS           = 2.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from RS_DIALOG_SHOW, DIAL| ).
    ENDIF.

  ENDMETHOD.