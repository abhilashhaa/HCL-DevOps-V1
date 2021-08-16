  METHOD zif_abapgit_tag_popups~tag_select_popup.

    DATA: lt_tags             TYPE zif_abapgit_definitions=>ty_git_tag_list_tt,
          lv_answer           TYPE c LENGTH 1,
          lt_selection        TYPE TABLE OF spopli,
          lv_name_with_prefix TYPE string.

    FIELD-SYMBOLS: <ls_sel> LIKE LINE OF lt_selection,
                   <ls_tag> LIKE LINE OF lt_tags.

    lt_tags = zcl_abapgit_factory=>get_branch_overview( io_repo )->get_tags( ).

    IF lines( lt_tags ) = 0.
      zcx_abapgit_exception=>raise( `There are no tags for this repository` ).
    ENDIF.

    LOOP AT lt_tags ASSIGNING <ls_tag>.

      INSERT INITIAL LINE INTO lt_selection INDEX 1 ASSIGNING <ls_sel>.
      <ls_sel>-varoption = zcl_abapgit_git_tag=>remove_tag_prefix( <ls_tag>-name ).

    ENDLOOP.

    CALL FUNCTION 'POPUP_TO_DECIDE_LIST'
      EXPORTING
        textline1          = 'Select tag'
        titel              = 'Select tag'
        start_col          = 30
        start_row          = 5
      IMPORTING
        answer             = lv_answer
      TABLES
        t_spopli           = lt_selection
      EXCEPTIONS
        not_enough_answers = 1
        too_much_answers   = 2
        too_much_marks     = 3
        OTHERS             = 4.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from POPUP_TO_DECIDE_LIST' ).
    ENDIF.

    IF lv_answer = 'A'.
      RETURN.
    ENDIF.

    READ TABLE lt_selection ASSIGNING <ls_sel> WITH KEY selflag = abap_true.
    ASSERT sy-subrc = 0.

    lv_name_with_prefix = zcl_abapgit_git_tag=>add_tag_prefix( <ls_sel>-varoption ).

    READ TABLE lt_tags ASSIGNING <ls_tag> WITH KEY name = lv_name_with_prefix.
    ASSERT sy-subrc = 0.

    rs_tag = <ls_tag>.

  ENDMETHOD.