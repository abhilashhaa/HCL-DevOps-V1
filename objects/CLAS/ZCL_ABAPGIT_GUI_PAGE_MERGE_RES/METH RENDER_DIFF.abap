  METHOD render_diff.

    DATA: lv_target_content TYPE string.
    FIELD-SYMBOLS: <ls_conflict> TYPE zif_abapgit_definitions=>ty_merge_conflict.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<div class="diff" data-type="{ is_diff-type
      }" data-changed-by="{ is_diff-changed_by
      }" data-file="{ is_diff-path && is_diff-filename }">| ).
    ri_html->add( render_diff_head( is_diff ) ).

    " Content
    IF is_diff-type <> 'binary'.

      IF mv_merge_mode = c_merge_mode-selection.
        ri_html->add( '<div class="diff_content">' ).
        ri_html->add( '<table class="diff_tab syntax-hl">' ).
        ri_html->add( render_table_head( ) ).
        ri_html->add( render_lines( is_diff ) ).
        ri_html->add( '</table>' ).
        ri_html->add( '</div>' ).
      ELSE.

        "Table for Div-Table and textarea
        ri_html->add( '<div class="diff_content">' ).
        ri_html->add( '<table class="w100">' ).
        ri_html->add( '<thead class="header">' ).
        ri_html->add( '<tr>' ).
        ri_html->add( '<th>Code</th>' ).
        ri_html->add( '<th>Merge - ' ).
        ri_html->add_a( iv_act = 'submitFormById(''merge_form'');'
                        iv_txt = 'Apply'
                        iv_typ = zif_abapgit_html=>c_action_type-onclick
                        iv_opt = zif_abapgit_html=>c_html_opt-strong ).
        ri_html->add( '</th> ' ).
        ri_html->add( '</tr>' ).
        ri_html->add( '</thead>' ).
        ri_html->add( '<td>' ).

        "Diff-Table of source and target file
        ri_html->add( '<table class="diff_tab syntax-hl">' ).
        ri_html->add( render_table_head( ) ).
        ri_html->add( render_lines( is_diff ) ).
        ri_html->add( '</table>' ).

        READ TABLE mt_conflicts ASSIGNING <ls_conflict> INDEX mv_current_conflict_index.
        IF sy-subrc = 0.
          lv_target_content = zcl_abapgit_convert=>xstring_to_string_utf8( <ls_conflict>-target_data ).
          lv_target_content = escape( val = lv_target_content
                                      format = cl_abap_format=>e_html_text ).
        ENDIF.

        ri_html->add( '</td>' ).
        ri_html->add( '<td>' ).
        ri_html->add( '<div class="form-container">' ).
        ri_html->add( |<form id="merge_form" class="aligned-form w100" accept-charset="UTF-8"| ).
        ri_html->add( |method="post" action="sapevent:apply_merge">| ).
        ri_html->add( |<textarea id="merge_content" name="merge_content" class="w100" | ).
        ri_html->add( |rows="{ lines( is_diff-o_diff->get( ) ) }">{ lv_target_content }</textarea>| ).
        ri_html->add( '<input type="submit" class="hidden-submit">' ).
        ri_html->add( '</form>' ).
        ri_html->add( '</div>' ).
        ri_html->add( '</td>' ).
        ri_html->add( '</table>' ).
        ri_html->add( '</div>' ).
      ENDIF.
    ELSE.
      ri_html->add( '<div class="diff_content paddings center grey">' ).
      ri_html->add( 'The content seems to be binary.' ).
      ri_html->add( 'Cannot display as diff.' ).
      ri_html->add( '</div>' ).
    ENDIF.

    ri_html->add( '</div>' ).

  ENDMETHOD.