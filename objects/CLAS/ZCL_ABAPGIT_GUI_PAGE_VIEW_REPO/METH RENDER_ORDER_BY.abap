  METHOD render_order_by.

    DATA:
      lv_icon     TYPE string,
      lt_col_spec TYPE zif_abapgit_definitions=>tty_col_spec,
      ls_col_spec TYPE zif_abapgit_definitions=>ty_col_spec.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    APPEND INITIAL LINE TO lt_col_spec.
    IF mv_are_changes_recorded_in_tr = abap_true.
      APPEND INITIAL LINE TO lt_col_spec.
    ENDIF.

    ls_col_spec-tech_name = 'OBJ_TYPE'.
    ls_col_spec-display_name = 'Type'.
    APPEND ls_col_spec TO lt_col_spec.

    ls_col_spec-tech_name = 'OBJ_NAME'.
    ls_col_spec-display_name = 'Name'.
    APPEND ls_col_spec TO lt_col_spec.

    ls_col_spec-tech_name = 'PATH'.
    ls_col_spec-display_name = 'Path'.
    APPEND ls_col_spec TO lt_col_spec.

    APPEND INITIAL LINE TO lt_col_spec.

    ri_html->add( |<thead>| ).
    ri_html->add( |<tr>| ).

    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_order_by_header_cells(
      it_col_spec         = lt_col_spec
      iv_order_by         = mv_order_by
      iv_order_descending = mv_order_descending ) ).

    IF mv_diff_first = abap_true.
      lv_icon = 'check/blue'.
    ELSE.
      lv_icon = 'check/grey'.
    ENDIF.

    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).

  ENDMETHOD.