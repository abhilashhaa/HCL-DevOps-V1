  METHOD zif_abapgit_object~delete.

    DATA: lv_transaction TYPE tstc-tcode.


    lv_transaction = ms_item-obj_name.

    CALL FUNCTION 'RPY_TRANSACTION_DELETE'
      EXPORTING
        transaction      = lv_transaction
      EXCEPTIONS
        not_excecuted    = 1
        object_not_found = 0
        OTHERS           = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from RPY_TRANSACTION_DELETE' ).
    ENDIF.

  ENDMETHOD.