  METHOD free_access_permission.
    CALL FUNCTION 'RS_ACCESS_PERMISSION'
      EXPORTING
        mode         = 'FREE'
        object       = iv_message_id
        object_class = 'T100'.
  ENDMETHOD.