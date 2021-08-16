  METHOD check_for_restart.

    CONSTANTS:
      lc_abapgit_prog TYPE progname VALUE `ZABAPGIT`.

    " If abapGit was used to update itself, then restart to avoid LOAD_PROGRAM_&_MISMATCH dumps
    " because abapGit code was changed at runtime
    IF zcl_abapgit_ui_factory=>get_gui_functions( )->gui_is_available( ) = abap_true AND
       zcl_abapgit_url=>is_abapgit_repo( ms_data-url ) = abap_true AND
       sy-batch = abap_false AND
       sy-cprog = lc_abapgit_prog.

      IF zcl_abapgit_persist_settings=>get_instance( )->read( )->get_show_default_repo( ) = abap_false.
        MESSAGE 'abapGit was updated and will restart itself' TYPE 'I'.
      ENDIF.

      SUBMIT (sy-cprog).

    ENDIF.

  ENDMETHOD.