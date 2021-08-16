  METHOD zif_abapgit_popups~branch_list_popup.

    DATA: lo_branches    TYPE REF TO zcl_abapgit_git_branch_list,
          lt_branches    TYPE zif_abapgit_definitions=>ty_git_branch_list_tt,
          lv_answer      TYPE c LENGTH 1,
          lv_default     TYPE i,
          lv_head_suffix TYPE string,
          lv_head_symref TYPE string,
          lv_text        TYPE string,
          lt_selection   TYPE TABLE OF spopli.

    FIELD-SYMBOLS: <ls_sel>    LIKE LINE OF lt_selection,
                   <ls_branch> LIKE LINE OF lt_branches.


    lo_branches    = zcl_abapgit_git_transport=>branches( iv_url ).
    lt_branches    = lo_branches->get_branches_only( ).
    lv_head_suffix = | ({ zif_abapgit_definitions=>c_head_name })|.
    lv_head_symref = lo_branches->get_head_symref( ).

    IF iv_hide_branch IS NOT INITIAL.
      DELETE lt_branches WHERE name = iv_hide_branch.
    ENDIF.

    IF iv_hide_head IS NOT INITIAL.
      DELETE lt_branches WHERE name    = zif_abapgit_definitions=>c_head_name
                            OR is_head = abap_true.
    ENDIF.

    IF lt_branches IS INITIAL.
      IF iv_hide_head IS NOT INITIAL.
        lv_text = 'master'.
      ENDIF.
      IF iv_hide_branch IS NOT INITIAL AND iv_hide_branch <> zif_abapgit_definitions=>c_git_branch-master.
        IF lv_text IS INITIAL.
          lv_text = iv_hide_branch && ' is'.
        ELSE.
          CONCATENATE lv_text 'and' iv_hide_branch 'are' INTO lv_text SEPARATED BY space.
        ENDIF.
      ELSE.
        lv_text = lv_text && ' is'.
      ENDIF.
      IF lv_text IS NOT INITIAL.
        zcx_abapgit_exception=>raise( 'No branches available to select (' && lv_text && ' hidden)' ).
      ELSE.
        zcx_abapgit_exception=>raise( 'No branches are available to select' ).
      ENDIF.
    ENDIF.

    LOOP AT lt_branches ASSIGNING <ls_branch>.

      CHECK <ls_branch>-name IS NOT INITIAL. " To ensure some below ifs

      IF <ls_branch>-is_head = abap_true.

        IF <ls_branch>-name = zif_abapgit_definitions=>c_head_name. " HEAD
          IF <ls_branch>-name <> lv_head_symref AND lv_head_symref IS NOT INITIAL.
            " HEAD but other HEAD symref exists - ignore
            CONTINUE.
          ELSE.
            INSERT INITIAL LINE INTO lt_selection INDEX 1 ASSIGNING <ls_sel>.
            <ls_sel>-varoption = <ls_branch>-name.
          ENDIF.
        ELSE.
          INSERT INITIAL LINE INTO lt_selection INDEX 1 ASSIGNING <ls_sel>.
          <ls_sel>-varoption = <ls_branch>-display_name && lv_head_suffix.
        ENDIF.

        IF lv_default > 0. " Shift down default if set
          lv_default = lv_default + 1.
        ENDIF.
      ELSE.
        APPEND INITIAL LINE TO lt_selection ASSIGNING <ls_sel>.
        <ls_sel>-varoption = <ls_branch>-display_name.
      ENDIF.

      IF <ls_branch>-name = iv_default_branch.
        IF <ls_branch>-is_head = abap_true.
          lv_default = 1.
        ELSE.
          lv_default = sy-tabix.
        ENDIF.
      ENDIF.

    ENDLOOP.

    IF iv_show_new_option = abap_true.
      APPEND INITIAL LINE TO lt_selection ASSIGNING <ls_sel>.
      <ls_sel>-varoption = zif_abapgit_popups=>c_new_branch_label.
    ENDIF.

    CALL FUNCTION 'POPUP_TO_DECIDE_LIST'
      EXPORTING
        textline1  = 'Select branch'
        titel      = 'Select branch'
        start_col  = 30
        start_row  = 5
        cursorline = lv_default
      IMPORTING
        answer     = lv_answer
      TABLES
        t_spopli   = lt_selection
      EXCEPTIONS
        OTHERS     = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from POPUP_TO_DECIDE_LIST' ).
    ENDIF.

    IF lv_answer = c_answer_cancel.
      RETURN.
    ENDIF.

    READ TABLE lt_selection ASSIGNING <ls_sel> WITH KEY selflag = abap_true.
    ASSERT sy-subrc = 0.

    IF iv_show_new_option = abap_true AND <ls_sel>-varoption = zif_abapgit_popups=>c_new_branch_label.
      rs_branch-name = zif_abapgit_popups=>c_new_branch_label.
    ELSE.
      REPLACE FIRST OCCURRENCE OF lv_head_suffix IN <ls_sel>-varoption WITH ''.
      READ TABLE lt_branches WITH KEY display_name = <ls_sel>-varoption ASSIGNING <ls_branch>.
      IF sy-subrc <> 0.
* branch name longer than 65 characters
        LOOP AT lt_branches ASSIGNING <ls_branch> WHERE display_name CS <ls_sel>-varoption.
          EXIT. " current loop
        ENDLOOP.
      ENDIF.
      ASSERT <ls_branch> IS ASSIGNED.
      rs_branch = lo_branches->find_by_name( <ls_branch>-name ).
      lv_text = |Branch switched from { zcl_abapgit_git_branch_list=>get_display_name( iv_default_branch ) } to {
        zcl_abapgit_git_branch_list=>get_display_name( rs_branch-name ) } |.
      MESSAGE lv_text TYPE 'S'.
    ENDIF.

  ENDMETHOD.