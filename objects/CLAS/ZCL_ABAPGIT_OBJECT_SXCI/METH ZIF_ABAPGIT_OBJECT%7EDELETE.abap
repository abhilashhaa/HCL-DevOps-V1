  METHOD zif_abapgit_object~delete.

    DATA: lv_implementation_name TYPE rsexscrn-imp_name.

    lv_implementation_name = ms_item-obj_name.

    CALL FUNCTION 'SXO_IMPL_DELETE'
      EXPORTING
        imp_name           = lv_implementation_name
        no_dialog          = abap_true
      EXCEPTIONS
        imp_not_existing   = 1
        action_canceled    = 2
        access_failure     = 3
        data_inconsistency = 4
        OTHERS             = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SXO_IMPL_DELETE' ).
    ENDIF.

  ENDMETHOD.