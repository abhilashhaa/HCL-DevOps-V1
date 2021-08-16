  METHOD render_lines.

    DATA: lo_highlighter TYPE REF TO zcl_abapgit_syntax_highlighter,
          lt_diffs       TYPE zif_abapgit_definitions=>ty_diffs_tt,
          lv_insert_nav  TYPE abap_bool,
          lv_tabix       TYPE syst-tabix.

    FIELD-SYMBOLS <ls_diff> LIKE LINE OF lt_diffs.

    lo_highlighter = zcl_abapgit_syntax_highlighter=>create( is_diff-filename ).
    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lt_diffs = is_diff-o_diff->get( ).

    lv_insert_nav = insert_nav( ).

    LOOP AT lt_diffs ASSIGNING <ls_diff>.

      lv_tabix = sy-tabix.

      IF <ls_diff>-short = abap_false.
        lv_insert_nav = abap_true.
        CONTINUE.
      ENDIF.

      IF lv_insert_nav = abap_true. " Insert separator line with navigation
        ri_html->add( render_beacon( is_diff_line = <ls_diff>
                                     is_diff = is_diff ) ).
        lv_insert_nav = abap_false.
      ENDIF.

      IF lo_highlighter IS BOUND.
        <ls_diff>-new = lo_highlighter->process_line( <ls_diff>-new ).
        <ls_diff>-old = lo_highlighter->process_line( <ls_diff>-old ).
      ELSE.
        <ls_diff>-new = escape( val = <ls_diff>-new
                                format = cl_abap_format=>e_html_attr ).
        <ls_diff>-old = escape( val = <ls_diff>-old
                                format = cl_abap_format=>e_html_attr ).
      ENDIF.

      CONDENSE <ls_diff>-new_num. "get rid of leading spaces
      CONDENSE <ls_diff>-old_num.

      IF mv_unified = abap_true.
        ri_html->add( render_line_unified( is_diff_line = <ls_diff> ) ).
      ELSE.
        ri_html->add( render_line_split( is_diff_line = <ls_diff>
                                         iv_filename  = get_normalized_fname_with_path( is_diff )
                                         iv_fstate    = is_diff-fstate
                                         iv_index     = lv_tabix ) ).
      ENDIF.

    ENDLOOP.

    IF mv_unified = abap_true.
      ri_html->add( render_line_unified( ) ). " Release delayed lines
    ENDIF.

  ENDMETHOD.