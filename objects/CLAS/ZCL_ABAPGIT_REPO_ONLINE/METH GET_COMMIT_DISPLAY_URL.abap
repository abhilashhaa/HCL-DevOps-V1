  METHOD get_commit_display_url.

    DATA ls_result TYPE match_result.
    FIELD-SYMBOLS <ls_provider_match> TYPE submatch_result.

    rv_url = me->get_url( ).

    FIND REGEX '^https:\/\/(?:www\.)?(github\.com|bitbucket\.org|gitlab\.com)\/' IN rv_url RESULTS ls_result.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |provider not yet supported| ).
    ENDIF.
    READ TABLE ls_result-submatches INDEX 1 ASSIGNING <ls_provider_match>.
    CASE rv_url+<ls_provider_match>-offset(<ls_provider_match>-length).
      WHEN 'github.com'.
        REPLACE REGEX '\.git$' IN rv_url WITH space.
        rv_url = rv_url && |/commit/| && iv_hash.
      WHEN 'bitbucket.org'.
        REPLACE REGEX '\.git$' IN rv_url WITH space.
        rv_url = rv_url && |/commits/| && iv_hash.
      WHEN 'gitlab.com'.
        REPLACE REGEX '\.git$' IN rv_url WITH space.
        rv_url = rv_url && |/-/commit/| && iv_hash.
    ENDCASE.

  ENDMETHOD.