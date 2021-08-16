  METHOD render_remotes.

    DATA lo_repo_online TYPE REF TO zcl_abapgit_repo_online.

    lo_repo_online ?= mo_repo.

    ii_html->add( '<h2>Remotes</h2>' ).
    ii_html->add( '<table class="settings">' ).

    " TODO maybe make it editable ?
    ii_html->add( render_table_row(
      iv_name  = 'Current remote'
      iv_value = |{ lo_repo_online->get_url( )
      } <span class="grey">@{ lo_repo_online->get_branch_name( ) }</span>| ) ).
    ii_html->add( render_table_row(
      iv_name  = 'Switched origin'
      iv_value = |<input name="switched_origin" type="text" size="60" value="{
        lo_repo_online->get_switched_origin( ) }">| ) ).

    ii_html->add( '</table>' ).

  ENDMETHOD.