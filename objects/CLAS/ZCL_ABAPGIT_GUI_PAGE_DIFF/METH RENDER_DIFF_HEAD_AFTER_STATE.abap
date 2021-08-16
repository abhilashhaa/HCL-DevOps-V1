  METHOD render_diff_head_after_state.

    IF is_diff-fstate = c_fstate-both AND mv_unified = abap_true.
      ii_html->add( '<span class="attention pad-sides">Attention: Unified mode'
                 && ' highlighting for MM assumes local file is newer ! </span>' ).
    ENDIF.

  ENDMETHOD.