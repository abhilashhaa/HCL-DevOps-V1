  METHOD render_header_bar.

    ii_html->add( |<div class="form-container">| ).

    ii_html->add( |<form class="inline" method="post" action="sapevent:{ c_action-apply_filter }">| ).

    ii_html->add( render_text_input(
      iv_name  = |filter|
      iv_label = |Filter: |
      iv_value = mv_filter ) ).
    ii_html->add( |<input type="submit" class="hidden-submit">| ).
    ii_html->add( |</form>| ).

    ii_html->add( ii_html->a(
      iv_txt = '<i id="icon-filter-favorite" class="icon icon-check"></i> Only Favorites'
      iv_act = |gHelper.toggleRepoListFavorites()|
      iv_typ = zif_abapgit_html=>c_action_type-onclick ) ).

    ii_html->add( `<span class="separator">|</span>` ).

    ii_html->add( ii_html->a(
      iv_txt = '<i id="icon-filter-detail" class="icon icon-check"></i> Detail'
      iv_act = |gHelper.toggleRepoListDetail()|
      iv_typ = zif_abapgit_html=>c_action_type-onclick ) ).

    ii_html->add( |</div>| ).

  ENDMETHOD.