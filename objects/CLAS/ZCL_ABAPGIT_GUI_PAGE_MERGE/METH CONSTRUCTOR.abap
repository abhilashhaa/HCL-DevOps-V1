  METHOD constructor.

    super->constructor( ).

    mo_repo = io_repo.

    io_repo->set_branch_name( |{ zif_abapgit_definitions=>c_git_branch-heads_prefix }{ iv_target }| ).

    CREATE OBJECT mo_merge
      EXPORTING
        io_repo          = io_repo
        iv_source_branch = iv_source.
    mo_merge->run( ).

    ms_control-page_title = 'Merge'.
    ms_control-page_menu  = build_menu( mo_merge->has_conflicts( ) ).

  ENDMETHOD.