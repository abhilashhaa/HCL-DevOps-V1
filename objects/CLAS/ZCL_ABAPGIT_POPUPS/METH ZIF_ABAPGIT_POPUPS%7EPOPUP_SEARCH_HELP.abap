  METHOD zif_abapgit_popups~popup_search_help.

    DATA lt_ret TYPE TABLE OF ddshretval.
    DATA ls_ret LIKE LINE OF lt_ret.
    DATA lv_tabname TYPE dfies-tabname.
    DATA lv_fieldname TYPE dfies-fieldname.

    SPLIT iv_tab_field AT '-' INTO lv_tabname lv_fieldname.
    lv_tabname = to_upper( lv_tabname ).
    lv_fieldname = to_upper( lv_fieldname ).

    CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
      EXPORTING
        tabname    = lv_tabname
        fieldname  = lv_fieldname
      TABLES
        return_tab = lt_ret
      EXCEPTIONS
        OTHERS     = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |F4IF_FIELD_VALUE_REQUEST error [{ iv_tab_field }]| ).
    ENDIF.

    IF lines( lt_ret ) > 0.
      READ TABLE lt_ret INDEX 1 INTO ls_ret.
      ASSERT sy-subrc = 0.
      rv_value = ls_ret-fieldval.
    ENDIF.

  ENDMETHOD.