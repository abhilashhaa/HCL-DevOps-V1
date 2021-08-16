  METHOD zif_abapgit_popups~choose_pr_popup.

    DATA lv_answer    TYPE c LENGTH 1.
    DATA lt_selection TYPE TABLE OF spopli.
    FIELD-SYMBOLS <ls_sel>  LIKE LINE OF lt_selection.
    FIELD-SYMBOLS <ls_pull> LIKE LINE OF it_pulls.

    IF lines( it_pulls ) = 0.
      zcx_abapgit_exception=>raise( 'No pull requests to select from' ).
    ENDIF.

    LOOP AT it_pulls ASSIGNING <ls_pull>.
      APPEND INITIAL LINE TO lt_selection ASSIGNING <ls_sel>.
      <ls_sel>-varoption = |{ <ls_pull>-number } - { <ls_pull>-title } @{ <ls_pull>-user }|.
    ENDLOOP.

    CALL FUNCTION 'POPUP_TO_DECIDE_LIST'
      EXPORTING
        textline1 = 'Select pull request'
        titel     = 'Select pull request'
        start_col = 30
        start_row = 5
      IMPORTING
        answer    = lv_answer
      TABLES
        t_spopli  = lt_selection
      EXCEPTIONS
        OTHERS    = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from POPUP_TO_DECIDE_LIST' ).
    ENDIF.

    IF lv_answer = c_answer_cancel.
      RETURN.
    ENDIF.

    READ TABLE lt_selection ASSIGNING <ls_sel> WITH KEY selflag = abap_true.
    ASSERT sy-subrc = 0.

    READ TABLE it_pulls INTO rs_pull INDEX sy-tabix.
    ASSERT sy-subrc = 0.

  ENDMETHOD.