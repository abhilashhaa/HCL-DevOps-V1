  METHOD create_provider.

    DATA li_agent TYPE REF TO zif_abapgit_http_agent.
    DATA lv_user TYPE string.
    DATA lv_repo TYPE string.

    li_agent = zcl_abapgit_factory=>get_http_agent( ).

    FIND ALL OCCURRENCES OF REGEX 'github\.com\/([^\/]+)\/([^\/]+)'
      IN iv_repo_url
      SUBMATCHES lv_user lv_repo.
    IF sy-subrc = 0.
      lv_repo = replace(
        val = lv_repo
        regex = '\.git$'
        with = '' ).
      CREATE OBJECT ri_provider TYPE zcl_abapgit_pr_enum_github
        EXPORTING
          iv_user_and_repo  = |{ lv_user }/{ lv_repo }|
          ii_http_agent     = li_agent.
    ELSE.
      zcx_abapgit_exception=>raise( |PR enumeration is not supported for { iv_repo_url }| ).
    ENDIF.

    " TODO somewhen more providers

  ENDMETHOD.