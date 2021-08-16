  METHOD zif_abapgit_object~jump.
    CALL FUNCTION 'RS_TOOL_ACCESS'
      EXPORTING
        operation           = 'SHOW'
        object_name         = ms_item-obj_name
        object_type         = 'DEVC'
        in_new_window       = abap_true
      EXCEPTIONS
        not_executed        = 1
        invalid_object_type = 2
        OTHERS              = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.
  ENDMETHOD.