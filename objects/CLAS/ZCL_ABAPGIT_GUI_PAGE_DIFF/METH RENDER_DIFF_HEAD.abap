  METHOD render_diff_head.

    DATA: ls_stats    TYPE zif_abapgit_definitions=>ty_count,
          lv_adt_link TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="diff_head">' ).

    ri_html->add_icon(
      iv_name    = 'chevron-down'
      iv_hint    = 'Collapse/Expand'
      iv_class   = 'cursor-pointer'
      iv_onclick = 'onDiffCollapse(event)' ).

    IF is_diff-type <> 'binary'.
      ls_stats = is_diff-o_diff->stats( ).
      IF is_diff-fstate = c_fstate-both. " Merge stats into 'update' if both were changed
        ls_stats-update = ls_stats-update + ls_stats-insert + ls_stats-delete.
        CLEAR: ls_stats-insert, ls_stats-delete.
      ENDIF.

      ri_html->add( |<span class="diff_banner diff_ins">+ { ls_stats-insert }</span>| ).
      ri_html->add( |<span class="diff_banner diff_del">- { ls_stats-delete }</span>| ).
      ri_html->add( |<span class="diff_banner diff_upd">~ { ls_stats-update }</span>| ).
    ENDIF.

    " no links for nonexistent or deleted objects
    IF is_diff-lstate IS NOT INITIAL AND is_diff-lstate <> 'D'.
      lv_adt_link = ri_html->a(
        iv_txt = |{ is_diff-path }{ is_diff-filename }|
        iv_typ = zif_abapgit_html=>c_action_type-sapevent
        iv_act = |jump?TYPE={ is_diff-obj_type }&NAME={ is_diff-obj_name }| ).
    ENDIF.

    IF lv_adt_link IS NOT INITIAL.
      ri_html->add( |<span class="diff_name">{ lv_adt_link }</span>| ).
    ELSE.
      ri_html->add( |<span class="diff_name">{ is_diff-path }{ is_diff-filename }</span>| ).
    ENDIF.

    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_item_state(
      iv_lstate = is_diff-lstate
      iv_rstate = is_diff-rstate ) ).

    render_diff_head_after_state(
      ii_html = ri_html
      is_diff = is_diff ).

    ri_html->add( |<span class="diff_changed_by">Last Changed by: <span class="user">{
      is_diff-changed_by }</span></span>| ).

    ri_html->add( '</div>' ).

  ENDMETHOD.