  METHOD render_menu.

    DATA lo_toolbar TYPE REF TO zcl_abapgit_html_toolbar.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    CREATE OBJECT lo_toolbar.

    lo_toolbar->add( iv_act = 'submitFormById(''commit_form'');'
                     iv_txt = 'Create'
                     iv_typ = zif_abapgit_html=>c_action_type-onclick
                     iv_opt = zif_abapgit_html=>c_html_opt-strong ).

    lo_toolbar->add( iv_act = c_action-commit_cancel
                     iv_txt = 'Cancel'
                     iv_opt = zif_abapgit_html=>c_html_opt-cancel ).

    ri_html->add( '<div class="paddings">' ).
    ri_html->add( lo_toolbar->render( ) ).
    ri_html->add( '</div>' ).

  ENDMETHOD.