  METHOD constructor.

    IF iv_source_branch = io_repo->get_branch_name( ).
      zcx_abapgit_exception=>raise( 'source = target' ).
    ENDIF.

    mo_repo = io_repo.
    mv_source_branch = iv_source_branch.

  ENDMETHOD.