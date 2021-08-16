  METHOD switch_repo_type.

    IF iv_offline = ms_data-offline.
      zcx_abapgit_exception=>raise( |Cannot switch_repo_type, offline already = "{ ms_data-offline }"| ).
    ENDIF.

    IF iv_offline = abap_true. " On-line -> OFFline
      set(
        iv_url         = zcl_abapgit_url=>name( ms_data-url )
        iv_branch_name = ''
        iv_head_branch = ''
        iv_offline     = abap_true ).
    ELSE. " OFFline -> On-line
      set( iv_offline = abap_false ).
    ENDIF.

  ENDMETHOD.