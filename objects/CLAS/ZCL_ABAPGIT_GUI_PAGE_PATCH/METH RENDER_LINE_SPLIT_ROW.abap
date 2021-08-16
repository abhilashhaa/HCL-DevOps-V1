  METHOD render_line_split_row.

    render_patch( ii_html      = ii_html
                  iv_filename  = iv_filename
                  is_diff_line = is_diff_line
                  iv_index     = iv_index ).

    super->render_line_split_row(
        ii_html      = ii_html
        iv_filename  = iv_filename
        is_diff_line = is_diff_line
        iv_index     = iv_index
        iv_fstate    = iv_fstate
        iv_new       = iv_new
        iv_old       = iv_old ).

  ENDMETHOD.