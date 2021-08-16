  METHOD zif_abapgit_object~jump.
    CALL FUNCTION 'RS_TOOL_ACCESS_REMOTE'
      STARTING NEW TASK 'GIT'
      EXPORTING
        operation   = 'SHOW'
        object_name = ms_item-obj_name
        object_type = ms_item-obj_type
      EXCEPTIONS
        OTHERS      = 0.
  ENDMETHOD.