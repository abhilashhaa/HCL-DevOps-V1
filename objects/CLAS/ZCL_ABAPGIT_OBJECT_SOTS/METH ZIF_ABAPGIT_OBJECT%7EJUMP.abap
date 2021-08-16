  METHOD zif_abapgit_object~jump.

    DATA: lv_object_name TYPE eu_lname,
          lv_object_type TYPE seu_obj.

    lv_object_name = ms_item-obj_name.
    lv_object_type = ms_item-obj_type.

    CALL FUNCTION 'RS_TOOL_ACCESS_REMOTE'
      DESTINATION 'NONE'
      EXPORTING
        operation           = 'SHOW'
        object_name         = lv_object_name
        object_type         = lv_object_type
      EXCEPTIONS
        not_executed        = 1
        invalid_object_type = 2
        OTHERS              = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from RS_TOOL_ACCESS Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.