  METHOD ask_user_for_check_variant.

    DATA: lt_return TYPE STANDARD TABLE OF ddshretval.

    FIELD-SYMBOLS: <ls_return> LIKE LINE OF lt_return.

    CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
      EXPORTING
        tabname           = 'SCI_DYNP'
        fieldname         = 'CHKV'
      TABLES
        return_tab        = lt_return
      EXCEPTIONS
        field_not_found   = 1
        no_help_for_field = 2
        inconsistent_help = 3
        no_values_found   = 4
        OTHERS            = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    READ TABLE lt_return ASSIGNING <ls_return>
                         WITH KEY retfield = 'SCI_DYNP-CHKV'.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Please select a check variant.| ).
    ENDIF.

    rv_check_variant = <ls_return>-fieldval.

  ENDMETHOD.