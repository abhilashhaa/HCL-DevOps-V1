  METHOD render_table_head_non_unified.

    render_patch_head( ii_html = ii_html
                       is_diff = is_diff ).

    super->render_table_head_non_unified(
        ii_html = ii_html
        is_diff = is_diff ).

  ENDMETHOD.