  METHOD constructor.

    super->constructor( ).

    mo_repo = io_repo.
    ms_control-page_title = 'Resolve Conflicts'.
    ms_control-page_menu  = build_menu( ).

    mo_merge_page = io_merge_page.
    mo_merge = io_merge.
    mv_merge_mode = c_merge_mode-selection.
    mv_current_conflict_index = 1.
    mt_conflicts = io_merge->get_conflicts( ).

  ENDMETHOD.