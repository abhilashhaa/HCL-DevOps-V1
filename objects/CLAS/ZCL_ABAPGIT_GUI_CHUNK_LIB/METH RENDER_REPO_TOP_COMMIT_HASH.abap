  METHOD render_repo_top_commit_hash.

    DATA: lv_commit_hash       TYPE zif_abapgit_definitions=>ty_sha1,
          lv_commit_short_hash TYPE zif_abapgit_definitions=>ty_sha1,
          lv_display_url       TYPE zif_abapgit_persistence=>ty_repo-url,
          lv_icon_commit       TYPE string.

    lv_commit_hash = io_repo_online->get_sha1_remote( ).
    lv_commit_short_hash = lv_commit_hash(7).

    lv_icon_commit = ii_html->icon( iv_name  = 'code-commit'
                                    iv_class = 'pad-sides'
                                    iv_hint  = 'Commit' ).

    TRY.
        lv_display_url = io_repo_online->get_commit_display_url( lv_commit_hash ).

        ii_html->add_a( iv_txt   = |{ lv_icon_commit }{ lv_commit_short_hash }|
                        iv_act   = |{ zif_abapgit_definitions=>c_action-url }?url={ lv_display_url }|
                        iv_class = |url| ).
      CATCH zcx_abapgit_exception.
        ii_html->add( |<span class="url">{ lv_icon_commit }{ lv_commit_short_hash }</span>| ).
    ENDTRY.

  ENDMETHOD.