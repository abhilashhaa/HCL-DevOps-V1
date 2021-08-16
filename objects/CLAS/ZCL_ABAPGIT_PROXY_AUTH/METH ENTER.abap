  METHOD enter.

    zcl_abapgit_password_dialog=>popup(
      EXPORTING
        iv_repo_url = 'Proxy Authentication'
      CHANGING
        cv_user     = gv_username
        cv_pass     = gv_password ).

    IF gv_username IS INITIAL OR gv_password IS INITIAL.
      zcx_abapgit_exception=>raise( 'Proxy auth failed' ).
    ENDIF.

  ENDMETHOD.