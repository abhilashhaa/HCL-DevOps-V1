  METHOD zif_abapgit_object~delete.

    DATA: ls_message TYPE hier_mess.

    CALL FUNCTION 'S_CUS_ACTIVITY_DELETE'
      EXPORTING
        activity = mv_customizing_activity
      IMPORTING
        message  = ls_message.

    IF ls_message-msgty <> 'S'.
      zcx_abapgit_exception=>raise( |error from delete CUS1 { mv_customizing_activity } S_CUS_ACTIVITY_DELETE| ).
    ENDIF.

  ENDMETHOD.