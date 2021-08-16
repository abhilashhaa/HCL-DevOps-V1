  METHOD _popup_3_get_values.

    DATA lv_answer TYPE c LENGTH 1.
    FIELD-SYMBOLS: <ls_field> TYPE sval.

    CALL FUNCTION 'POPUP_GET_VALUES'
      EXPORTING
        no_value_check = iv_no_value_check
        popup_title    = iv_popup_title
      IMPORTING
        returncode     = lv_answer
      TABLES
        fields         = ct_fields
      EXCEPTIONS
        OTHERS         = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from POPUP_GET_VALUES' ).
    ENDIF.

    IF lv_answer = c_answer_cancel.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    IF ev_value_1 IS SUPPLIED.
      READ TABLE ct_fields INDEX 1 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      ev_value_1 = <ls_field>-value.
    ENDIF.

    IF ev_value_2 IS SUPPLIED.
      READ TABLE ct_fields INDEX 2 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      ev_value_2 = <ls_field>-value.
    ENDIF.

    IF ev_value_3 IS SUPPLIED.
      READ TABLE ct_fields INDEX 3 ASSIGNING <ls_field>.
      ASSERT sy-subrc = 0.
      ev_value_3 = <ls_field>-value.
    ENDIF.

  ENDMETHOD.