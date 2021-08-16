  METHOD jump_se11.

    CALL FUNCTION 'RS_TOOL_ACCESS'
      EXPORTING
        operation           = 'SHOW'
        object_name         = ms_item-obj_name
        object_type         = ms_item-obj_type
        devclass            = ms_item-devclass
        in_new_window       = abap_true
      EXCEPTIONS
        not_executed        = 1
        invalid_object_type = 2
        OTHERS              = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Jump to SE11 failed (subrc={ sy-subrc } ).| ).
    ENDIF.

  ENDMETHOD.