  METHOD constructor.

    mv_repo_url   = |https://api.github.com/repos/{ iv_user_and_repo }|.
    mi_http_agent = ii_http_agent.
    mi_http_agent->global_headers( )->set(
      iv_key = 'Accept'
      iv_val = 'application/vnd.github.v3+json' ).

    IF zcl_abapgit_login_manager=>get( mv_repo_url ) IS NOT INITIAL.
      mi_http_agent->global_headers( )->set(
        iv_key = 'Authorization'
        iv_val = zcl_abapgit_login_manager=>get( mv_repo_url ) ).
    ENDIF.

  ENDMETHOD.