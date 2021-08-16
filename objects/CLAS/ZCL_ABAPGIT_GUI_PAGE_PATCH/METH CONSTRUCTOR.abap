  METHOD constructor.

    super->constructor(
      iv_key    = iv_key
      is_file   = is_file
      is_object = is_object
      it_files  = it_files ).

    IF mo_repo->is_offline( ) = abap_true.
      zcx_abapgit_exception=>raise( |Can't patch offline repos| ).
    ENDIF.

    mo_repo_online ?= mo_repo.

    " While patching we always want to be in split mode
    CLEAR: mv_unified.
    CREATE OBJECT mo_stage.

    ms_control-page_title = 'Patch'.
    ms_control-page_menu = build_menu( ).

  ENDMETHOD.