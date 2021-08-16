  METHOD zif_abapgit_object~delete.

    DATA: ls_message TYPE hier_mess.

    CALL FUNCTION 'S_CUS_ATTRIBUTES_DELETE'
      EXPORTING
        img_attribute = mv_img_attribute
      IMPORTING
        message       = ls_message.

    IF ls_message-msgty <> 'S'.
      zcx_abapgit_exception=>raise( |error from delete CUS2 { mv_img_attribute } S_CUS_ATTRIBUTES_DELETE| ).
    ENDIF.

  ENDMETHOD.