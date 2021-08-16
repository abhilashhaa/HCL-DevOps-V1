  METHOD checkout_commit_build_popup.

    DATA: lt_columns         TYPE zif_abapgit_definitions=>ty_alv_column_tt,
          li_popups          TYPE REF TO zif_abapgit_popups,
          lt_selected_values TYPE ty_commit_value_tab_tt.

    FIELD-SYMBOLS: <ls_value_tab> TYPE ty_commit_value_tab,
                   <ls_column>    TYPE zif_abapgit_definitions=>ty_alv_column.

    CLEAR: es_selected_commit.

    APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
    <ls_column>-name   = 'SHA1'.
    <ls_column>-text   = 'Hash'.
    <ls_column>-length = 7.
    APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
    <ls_column>-name = 'MESSAGE'.
    <ls_column>-text = 'Message'.
    APPEND INITIAL LINE TO lt_columns ASSIGNING <ls_column>.
    <ls_column>-name = 'DATETIME'.
    <ls_column>-text = 'Datetime'.

    li_popups = zcl_abapgit_ui_factory=>get_popups( ).
    li_popups->popup_to_select_from_list(
      EXPORTING
        it_list               = ct_value_tab
        iv_title              = |Checkout Commit|
        iv_end_column         = 83
        iv_striped_pattern    = abap_true
        iv_optimize_col_width = abap_false
        iv_selection_mode     = if_salv_c_selection_mode=>single
        it_columns_to_display = lt_columns
      IMPORTING
        et_list              = lt_selected_values ).

    IF lt_selected_values IS INITIAL.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    READ TABLE lt_selected_values
      ASSIGNING <ls_value_tab>
      INDEX 1.

    IF <ls_value_tab> IS NOT ASSIGNED.
      zcx_abapgit_exception=>raise( |Though result set of popup wasn't empty selected value couldn't retrieved.| ).
    ENDIF.

    READ TABLE it_commits
      INTO es_selected_commit
      WITH KEY sha1 = <ls_value_tab>-sha1.

  ENDMETHOD.