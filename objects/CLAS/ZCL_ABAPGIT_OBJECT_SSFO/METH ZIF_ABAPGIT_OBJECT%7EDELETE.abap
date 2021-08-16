  METHOD zif_abapgit_object~delete.

    DATA: lv_formname TYPE tdsfname.

    lv_formname = ms_item-obj_name.

    CALL FUNCTION 'FB_DELETE_FORM'
      EXPORTING
        i_formname            = lv_formname
        i_with_dialog         = abap_false
        i_with_confirm_dialog = abap_false
      EXCEPTIONS
        no_form               = 1
        OTHERS                = 2.
    IF sy-subrc <> 0 AND sy-subrc <> 1.
      zcx_abapgit_exception=>raise( 'Error from FB_DELETE_FORM' ).
    ENDIF.

  ENDMETHOD.