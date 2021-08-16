  METHOD render_table_head.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<thead class="header">' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<th class="num"></th>' ).

    IF mv_merge_mode = c_merge_mode-selection.
      ri_html->add( '<form id="target_form" method="post" action="sapevent:apply_target">' ).
      ri_html->add( '<th>Target - ' && mo_repo->get_branch_name( ) && ' - ' ).
      ri_html->add_a( iv_act = 'submitFormById(''target_form'');'
                      iv_txt = 'Apply'
                      iv_typ = zif_abapgit_html=>c_action_type-onclick
                      iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      ri_html->add( '</th> ' ).
      ri_html->add( '</form>' ).
      ri_html->add( '<th class="num"></th>' ).
      ri_html->add( '<form id="source_form" method="post" action="sapevent:apply_source">' ).
      ri_html->add( '<th>Source  - ' && mo_merge->get_source_branch( ) && ' - ' ).
      ri_html->add_a( iv_act = 'submitFormById(''source_form'');'
                      iv_txt = 'Apply'
                      iv_typ = zif_abapgit_html=>c_action_type-onclick
                      iv_opt = zif_abapgit_html=>c_html_opt-strong ).
      ri_html->add( '</th> ' ).
      ri_html->add( '</form>' ).
    ELSE.
      ri_html->add( '<th>Target - ' && mo_repo->get_branch_name( ) && '</th> ' ).
      ri_html->add( '<th class="num"></th>' ).
      ri_html->add( '<th>Source - ' && mo_merge->get_source_branch( ) && '</th> ' ).
    ENDIF.

    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).

  ENDMETHOD.