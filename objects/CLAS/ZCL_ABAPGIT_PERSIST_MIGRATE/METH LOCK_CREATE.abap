  METHOD lock_create.

    DATA: lv_obj_name TYPE tadir-obj_name,
          ls_dd25v    TYPE dd25v,
          lt_dd26e    TYPE STANDARD TABLE OF dd26e WITH DEFAULT KEY,
          lt_dd27p    TYPE STANDARD TABLE OF dd27p WITH DEFAULT KEY.

    FIELD-SYMBOLS: <ls_dd26e> LIKE LINE OF lt_dd26e,
                   <ls_dd27p> LIKE LINE OF lt_dd27p.


    ls_dd25v-viewname   = zcl_abapgit_persistence_db=>c_lock.
    ls_dd25v-aggtype    = 'E'.
    ls_dd25v-roottab    = zcl_abapgit_persistence_db=>c_tabname.
    ls_dd25v-ddlanguage = zif_abapgit_definitions=>c_english.
    ls_dd25v-ddtext     = c_text.

    APPEND INITIAL LINE TO lt_dd26e ASSIGNING <ls_dd26e>.
    <ls_dd26e>-viewname   = zcl_abapgit_persistence_db=>c_lock.
    <ls_dd26e>-tabname    = zcl_abapgit_persistence_db=>c_tabname.
    <ls_dd26e>-tabpos     = '0001'.
    <ls_dd26e>-fortabname = zcl_abapgit_persistence_db=>c_tabname.
    <ls_dd26e>-enqmode    = 'E'.

    APPEND INITIAL LINE TO lt_dd27p ASSIGNING <ls_dd27p>.
    <ls_dd27p>-viewname  = zcl_abapgit_persistence_db=>c_lock.
    <ls_dd27p>-objpos    = '0001'.
    <ls_dd27p>-viewfield = 'TYPE'.
    <ls_dd27p>-tabname   = zcl_abapgit_persistence_db=>c_tabname.
    <ls_dd27p>-fieldname = 'TYPE'.
    <ls_dd27p>-keyflag   = abap_true.

    APPEND INITIAL LINE TO lt_dd27p ASSIGNING <ls_dd27p>.
    <ls_dd27p>-viewname  = zcl_abapgit_persistence_db=>c_lock.
    <ls_dd27p>-objpos    = '0002'.
    <ls_dd27p>-viewfield = 'VALUE'.
    <ls_dd27p>-tabname   = zcl_abapgit_persistence_db=>c_tabname.
    <ls_dd27p>-fieldname = 'VALUE'.
    <ls_dd27p>-keyflag   = abap_true.

    CALL FUNCTION 'DDIF_ENQU_PUT'
      EXPORTING
        name              = zcl_abapgit_persistence_db=>c_lock
        dd25v_wa          = ls_dd25v
      TABLES
        dd26e_tab         = lt_dd26e
        dd27p_tab         = lt_dd27p
      EXCEPTIONS
        enqu_not_found    = 1
        name_inconsistent = 2
        enqu_inconsistent = 3
        put_failure       = 4
        put_refused       = 5
        OTHERS            = 6.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'migrate, error from DDIF_ENQU_PUT' ).
    ENDIF.

    lv_obj_name = zcl_abapgit_persistence_db=>c_lock.
    CALL FUNCTION 'TR_TADIR_INTERFACE'
      EXPORTING
        wi_tadir_pgmid    = 'R3TR'
        wi_tadir_object   = 'ENQU'
        wi_tadir_obj_name = lv_obj_name
        wi_set_genflag    = abap_true
        wi_test_modus     = abap_false
        wi_tadir_devclass = '$TMP'
      EXCEPTIONS
        OTHERS            = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'migrate, error from TR_TADIR_INTERFACE' ).
    ENDIF.

    CALL FUNCTION 'DDIF_ENQU_ACTIVATE'
      EXPORTING
        name        = zcl_abapgit_persistence_db=>c_lock
      EXCEPTIONS
        not_found   = 1
        put_failure = 2
        OTHERS      = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'migrate, error from DDIF_ENQU_ACTIVATE' ).
    ENDIF.

  ENDMETHOD.