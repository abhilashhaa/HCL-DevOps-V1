  METHOD zif_abapgit_object~jump.

    CALL FUNCTION 'RS_TOOL_ACCESS'
      EXPORTING
        operation     = 'SHOW'
        object_name   = mv_profile
        object_type   = 'OA2P'
        in_new_window = abap_true.

  ENDMETHOD.