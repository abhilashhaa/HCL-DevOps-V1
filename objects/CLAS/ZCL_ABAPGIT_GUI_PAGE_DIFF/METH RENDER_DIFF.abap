  METHOD render_diff.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<div class="diff" data-type="{ is_diff-type
      }" data-changed-by="{ is_diff-changed_by
      }" data-file="{ is_diff-path && is_diff-filename }">| ).
    ri_html->add( render_diff_head( is_diff ) ).

    " Content
    IF is_diff-type <> 'binary'.
      ri_html->add( '<div class="diff_content">' ).
      ri_html->add( |<table class="diff_tab syntax-hl" id={ is_diff-filename }>| ).
      ri_html->add( render_table_head( is_diff ) ).
      ri_html->add( render_lines( is_diff ) ).
      ri_html->add( '</table>' ).
    ELSE.
      ri_html->add( '<div class="diff_content paddings center grey">' ).
      ri_html->add( 'The content seems to be binary.' ).
      ri_html->add( 'Cannot display as diff.' ).
    ENDIF.
    ri_html->add( '</div>' ).

    ri_html->add( '</div>' ).

  ENDMETHOD.