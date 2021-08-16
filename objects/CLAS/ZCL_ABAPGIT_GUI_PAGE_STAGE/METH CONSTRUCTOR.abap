  METHOD constructor.

    DATA lv_ts TYPE timestamp.

    super->constructor( ).

    ms_control-page_title = 'Stage'.
    mo_repo               = io_repo.
    ms_files              = zcl_abapgit_factory=>get_stage_logic( )->get( mo_repo ).
    mv_seed               = iv_seed.

    IF mv_seed IS INITIAL. " Generate based on time unless obtained from diff page
      GET TIME STAMP FIELD lv_ts.
      mv_seed = |stage{ lv_ts }|.
    ENDIF.

    ms_control-page_menu  = build_menu( ).

    IF lines( ms_files-local ) = 0 AND lines( ms_files-remote ) = 0.
      zcx_abapgit_exception=>raise( 'There are no changes that could be staged' ).
    ENDIF.

  ENDMETHOD.