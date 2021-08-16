  METHOD deserialize_program.

    DATA: lv_exists      TYPE abap_bool,
          lv_progname    TYPE reposrc-progname,
          ls_tpool       LIKE LINE OF it_tpool,
          lv_title       TYPE rglif-title,
          ls_progdir_new TYPE progdir.

    FIELD-SYMBOLS: <lg_any> TYPE any.


    CALL FUNCTION 'RS_CORR_INSERT'
      EXPORTING
        object              = is_progdir-name
        object_class        = 'ABAP'
        devclass            = iv_package
        master_language     = mv_language
        mode                = 'I'
        suppress_dialog     = abap_true
      EXCEPTIONS
        cancelled           = 1
        permission_failure  = 2
        unknown_objectclass = 3
        OTHERS              = 4.
    IF sy-subrc = 1.
      zcx_abapgit_exception=>raise( |Error from RS_CORR_INSERT, Cancelled, { sy-msgid }, { sy-msgno }| ).
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from RS_CORR_INSERT, { sy-msgid }, { sy-msgno }| ).
    ENDIF.

    READ TABLE it_tpool INTO ls_tpool WITH KEY id = 'R'.
    IF sy-subrc = 0.
* there is a bug in RPY_PROGRAM_UPDATE, the header line of TTAB is not
* cleared, so the title length might be inherited from a different program.
      ASSIGN ('(SAPLSIFP)TTAB') TO <lg_any>.
      IF sy-subrc = 0.
        CLEAR <lg_any>.
      ENDIF.

      lv_title = ls_tpool-entry.
    ENDIF.

    SELECT SINGLE progname FROM reposrc INTO lv_progname
      WHERE progname = is_progdir-name
      AND r3state = 'A'.
    lv_exists = boolc( sy-subrc = 0 ).

    IF lv_exists = abap_true.
      zcl_abapgit_language=>set_current_language( mv_language ).

      CALL FUNCTION 'RPY_PROGRAM_UPDATE'
        EXPORTING
          program_name     = is_progdir-name
          title_string     = lv_title
          save_inactive    = 'I'
        TABLES
          source_extended  = it_source
        EXCEPTIONS
          cancelled        = 1
          permission_error = 2
          not_found        = 3
          OTHERS           = 4.

      IF sy-subrc <> 0.
        zcl_abapgit_language=>restore_login_language( ).

        IF sy-msgid = 'EU' AND sy-msgno = '510'.
          zcx_abapgit_exception=>raise( 'User is currently editing program' ).
        ELSEIF sy-msgid = 'EU' AND sy-msgno = '522'.
* for generated table maintenance function groups, the author is set to SAP* instead of the user which
* generates the function group. This hits some standard checks, pulling new code again sets the author
* to the current user which avoids the check
          zcx_abapgit_exception=>raise( |Delete function group and pull again, { is_progdir-name } (EU522)| ).
        ELSE.
          zcx_abapgit_exception=>raise( |PROG { is_progdir-name }, updating error: { sy-msgid } { sy-msgno }| ).
        ENDIF.
      ENDIF.

      zcl_abapgit_language=>restore_login_language( ).
    ELSEIF strlen( is_progdir-name ) > 30.
* function module RPY_PROGRAM_INSERT cannot handle function group includes

      " special treatment for extensions
      " if the program name exceeds 30 characters it is not a usual
      " ABAP program but might be some extension, which requires the internal
      " addition EXTENSION TYPE, see
      " http://help.sap.com/abapdocu_751/en/abapinsert_report_internal.htm#!ABAP_ADDITION_1@1@
      " This e.g. occurs in case of transportable Code Inspector variants (ending with ===VC)
      INSERT REPORT is_progdir-name
        FROM it_source
        STATE 'I'
        EXTENSION TYPE is_progdir-name+30.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from INSERT REPORT .. EXTENSION TYPE' ).
      ENDIF.
    ELSE.
      INSERT REPORT is_progdir-name
        FROM it_source
        STATE 'I'
        PROGRAM TYPE is_progdir-subc.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from INSERT REPORT' ).
      ENDIF.
    ENDIF.

    IF NOT it_tpool[] IS INITIAL.
      INSERT TEXTPOOL is_progdir-name
        FROM it_tpool
        LANGUAGE mv_language
        STATE 'I'.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'error from INSERT TEXTPOOL' ).
      ENDIF.
    ENDIF.

    CALL FUNCTION 'READ_PROGDIR'
      EXPORTING
        i_progname = is_progdir-name
        i_state    = 'I'
      IMPORTING
        e_progdir  = ls_progdir_new
      EXCEPTIONS
        not_exists = 1
        OTHERS     = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |not found in PROGDIR. Subrc = { sy-subrc }| ).
    ENDIF.

* todo, package?

    ls_progdir_new-ldbname = is_progdir-ldbname.
    ls_progdir_new-dbna    = is_progdir-dbna.
    ls_progdir_new-dbapl   = is_progdir-dbapl.
    ls_progdir_new-rload   = is_progdir-rload.
    ls_progdir_new-fixpt   = is_progdir-fixpt.
    ls_progdir_new-varcl   = is_progdir-varcl.
    ls_progdir_new-appl    = is_progdir-appl.
    ls_progdir_new-rstat   = is_progdir-rstat.
    ls_progdir_new-sqlx    = is_progdir-sqlx.
    ls_progdir_new-uccheck = is_progdir-uccheck.
    ls_progdir_new-clas    = is_progdir-clas.

    CALL FUNCTION 'UPDATE_PROGDIR'
      EXPORTING
        i_progdir    = ls_progdir_new
        i_progname   = ls_progdir_new-name
        i_state      = ls_progdir_new-state
      EXCEPTIONS
        not_executed = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |PROG, error inserting. Subrc = { sy-subrc }| ).
    ENDIF.

    SELECT SINGLE * FROM progdir INTO ls_progdir_new
      WHERE name = ls_progdir_new-name
      AND state = ls_progdir_new-state.
    IF sy-subrc = 0 AND is_progdir-varcl = space AND ls_progdir_new-varcl = abap_true.
* function module UPDATE_PROGDIR does not update VARCL
      UPDATE progdir SET varcl = is_progdir-varcl
        WHERE name = ls_progdir_new-name
        AND state = ls_progdir_new-state.                 "#EC CI_SUBRC
    ENDIF.

    zcl_abapgit_objects_activation=>add(
      iv_type = 'REPS'
      iv_name = is_progdir-name ).

  ENDMETHOD.