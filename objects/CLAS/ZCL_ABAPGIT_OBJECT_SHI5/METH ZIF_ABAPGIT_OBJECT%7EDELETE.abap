  METHOD zif_abapgit_object~delete.

    DATA: ls_message             TYPE hier_mess,
          lv_deletion_successful TYPE hier_yesno.

    CALL FUNCTION 'STREE_EXTENSION_DELETE'
      EXPORTING
        extension           = mv_extension
      IMPORTING
        message             = ls_message
        deletion_successful = lv_deletion_successful.

    IF lv_deletion_successful = abap_false.
      zcx_abapgit_exception=>raise( ls_message-msgtxt ).
    ENDIF.

  ENDMETHOD.