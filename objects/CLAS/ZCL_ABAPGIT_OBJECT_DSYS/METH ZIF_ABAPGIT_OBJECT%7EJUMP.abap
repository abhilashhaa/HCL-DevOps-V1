  METHOD zif_abapgit_object~jump.

    DATA lv_lang TYPE sy-langu.

    lv_lang = get_master_lang( ).

    CALL FUNCTION 'DSYS_EDIT'
      EXPORTING
        dokclass         = mv_doc_object+0(4)
        dokname          = mv_doc_object+4(*)
        doklangu         = lv_lang
      EXCEPTIONS
        class_unknown    = 1
        object_not_found = 2
        OTHERS           = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from DSYS_EDIT' ).
    ENDIF.

  ENDMETHOD.