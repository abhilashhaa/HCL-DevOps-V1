  METHOD zif_abapgit_object~jump.

    DATA: lt_bdcdata  TYPE TABLE OF bdcdata,
          lv_formtype TYPE stxfadm-formtype.

    FIELD-SYMBOLS: <ls_bdcdata> LIKE LINE OF lt_bdcdata.

    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-program  = 'SAPMSSFO'.
    <ls_bdcdata>-dynpro   = '0100'.
    <ls_bdcdata>-dynbegin = abap_true.

    SELECT SINGLE formtype FROM stxfadm INTO lv_formtype
           WHERE formname = ms_item-obj_name.

    IF lv_formtype = cssf_formtype_text.

      APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
      <ls_bdcdata>-fnam = 'RB_TX'.
      <ls_bdcdata>-fval = abap_true.

      APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
      <ls_bdcdata>-fnam = 'BDC_OKCODE'.
      <ls_bdcdata>-fval = '=RB'.

      APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
      <ls_bdcdata>-program  = 'SAPMSSFO'.
      <ls_bdcdata>-dynpro   = '0100'.
      <ls_bdcdata>-dynbegin = abap_true.

      APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
      <ls_bdcdata>-fnam = 'SSFSCREEN-TNAME'.
      <ls_bdcdata>-fval = ms_item-obj_name.

    ELSE.

      APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
      <ls_bdcdata>-fnam = 'SSFSCREEN-FNAME'.
      <ls_bdcdata>-fval = ms_item-obj_name.

    ENDIF.

    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'BDC_OKCODE'.
    <ls_bdcdata>-fval = '=DISPLAY'.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode     = 'SMARTFORMS'
        mode_val  = 'E'
      TABLES
        using_tab = lt_bdcdata
      EXCEPTIONS
        OTHERS    = 1
        ##fm_subrc_ok.                                                   "#EC CI_SUBRC

  ENDMETHOD.