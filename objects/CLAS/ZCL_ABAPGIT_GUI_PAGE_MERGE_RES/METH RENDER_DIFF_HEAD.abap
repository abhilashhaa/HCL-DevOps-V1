  METHOD render_diff_head.

    DATA: ls_stats TYPE zif_abapgit_definitions=>ty_count.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="diff_head">' ).

    IF is_diff-type <> 'binary' AND is_diff-o_diff IS NOT INITIAL.
      ls_stats = is_diff-o_diff->stats( ).
      ri_html->add( |<span class="diff_banner diff_ins">+ { ls_stats-insert }</span>| ).
      ri_html->add( |<span class="diff_banner diff_del">- { ls_stats-delete }</span>| ).
      ri_html->add( |<span class="diff_banner diff_upd">~ { ls_stats-update }</span>| ).
    ENDIF.

    ri_html->add( |<span class="diff_name">{ is_diff-filename }</span>| ).
    ri_html->add( '</div>' ).

  ENDMETHOD.