  METHOD save_remotes.

    DATA ls_post_field LIKE LINE OF it_post_fields.
    DATA lo_online_repo TYPE REF TO zcl_abapgit_repo_online.

    IF mo_repo->is_offline( ) = abap_true.
      RETURN.
    ENDIF.

    lo_online_repo ?= mo_repo.

    READ TABLE it_post_fields INTO ls_post_field WITH KEY name = 'switched_origin'.
    ASSERT sy-subrc = 0.
    lo_online_repo->switch_origin(
      iv_url       = ls_post_field-value
      iv_overwrite = abap_true ).

  ENDMETHOD.