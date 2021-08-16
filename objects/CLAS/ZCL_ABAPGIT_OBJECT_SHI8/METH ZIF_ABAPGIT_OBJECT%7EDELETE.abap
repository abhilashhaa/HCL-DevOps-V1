  METHOD zif_abapgit_object~delete.

    DATA: lv_deleted TYPE abap_bool,
          ls_message TYPE hier_mess.

    CALL FUNCTION 'STREE_SFW_ASSIGNMENT_DELETE'
      EXPORTING
        assignment_id = mv_assignment_id
      IMPORTING
        id_deleted    = lv_deleted
        message       = ls_message.

    IF lv_deleted = abap_false.
      zcx_abapgit_exception=>raise( |{ ls_message-msgtxt }| ).
    ENDIF.

  ENDMETHOD.