  METHOD popup_token.

    DATA: lv_returncode TYPE c,
          lt_fields     TYPE TABLE OF sval.

    FIELD-SYMBOLS: <ls_field> LIKE LINE OF lt_fields.


    APPEND INITIAL LINE TO lt_fields ASSIGNING <ls_field>.
    <ls_field>-tabname   = 'TADIR'.
    <ls_field>-fieldname = 'OBJ_NAME'.
    <ls_field>-fieldtext = 'Two factor auth. token'.

    CALL FUNCTION 'POPUP_GET_VALUES'
      EXPORTING
        no_value_check  = abap_true
        popup_title     = 'Two factor auth. token'
      IMPORTING
        returncode      = lv_returncode
      TABLES
        fields          = lt_fields
      EXCEPTIONS
        error_in_fields = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from POPUP_GET_VALUES' ).
    ENDIF.

    IF lv_returncode = 'A'.
      zcx_abapgit_exception=>raise( 'Authentication cancelled' ).
    ENDIF.

    READ TABLE lt_fields INDEX 1 ASSIGNING <ls_field>.
    ASSERT sy-subrc = 0.
    rv_token = <ls_field>-value.

  ENDMETHOD.