  METHOD constructor.
    super->constructor( ).

    mo_repo_online ?= io_repo.

    ms_control-page_title = 'Tag'.
    mv_selected_type = c_tag_type-lightweight.

  ENDMETHOD.