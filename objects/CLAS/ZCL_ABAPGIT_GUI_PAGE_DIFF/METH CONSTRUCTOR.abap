  METHOD constructor.

    DATA: lv_ts TYPE timestamp.

    super->constructor( ).
    ms_control-page_title = 'Diff'.
    mv_unified            = zcl_abapgit_persistence_user=>get_instance( )->get_diff_unified( ).
    mv_repo_key           = iv_key.
    mo_repo              ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    GET TIME STAMP FIELD lv_ts.
    mv_seed = |diff{ lv_ts }|. " Generate based on time

    ASSERT is_file IS INITIAL OR is_object IS INITIAL. " just one passed

    calculate_diff(
        is_file   = is_file
        is_object = is_object
        it_files  = it_files ).

    IF lines( mt_diff_files ) = 0.
      zcx_abapgit_exception=>raise( 'PAGE_DIFF ERROR: No diff files found' ).
    ENDIF.

    ms_control-page_menu = build_menu( ).

  ENDMETHOD.