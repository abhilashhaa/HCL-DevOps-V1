  METHOD create.

    CONSTANTS: " TODO refactor
      lc_log_path        TYPE string VALUE '/',
      lc_log_filename    TYPE string VALUE 'changelog*',
      lc_log_filename_up TYPE string VALUE 'CHANGELOG*'.

    DATA: lo_apack       TYPE REF TO zcl_abapgit_apack_reader,
          lt_remote      TYPE zif_abapgit_definitions=>ty_files_tt,
          lv_version     TYPE string,
          lv_last_seen   TYPE string,
          lv_url         TYPE string,
          lo_repo_online TYPE REF TO zcl_abapgit_repo_online.

    FIELD-SYMBOLS <ls_file> LIKE LINE OF lt_remote.


    IF io_repo->is_offline( ) = abap_true.
      RETURN.
    ENDIF.

    lo_repo_online ?= io_repo.
    lv_url          = lo_repo_online->get_url( ).

    IF zcl_abapgit_url=>is_abapgit_repo( lv_url ) = abap_true.
      lv_version = zif_abapgit_version=>gc_abap_version. " TODO refactor
    ELSE.

      lo_apack = io_repo->get_dot_apack( ).
      IF lo_apack IS NOT BOUND.
        RETURN.
      ENDIF.

      lv_version = lo_apack->get_manifest_descriptor( )-version.

    ENDIF.

    IF lv_version IS INITIAL.
      RETURN.
    ENDIF.

    lv_last_seen = zcl_abapgit_persistence_user=>get_instance( )->get_repo_last_change_seen( lv_url ).

    TRY. " Find changelog
        lt_remote = io_repo->get_files_remote( ).
      CATCH zcx_abapgit_exception.
        RETURN.
    ENDTRY.

    LOOP AT lt_remote ASSIGNING <ls_file> WHERE path = lc_log_path
                                            AND ( filename CP lc_log_filename OR filename CP lc_log_filename_up ).

      CREATE OBJECT ro_instance
        EXPORTING
          iv_rawdata          = <ls_file>-data
          iv_current_version  = lv_version
          iv_lastseen_version = normalize_version( lv_last_seen ).

      EXIT.

    ENDLOOP.

    IF ro_instance IS BOUND AND lv_last_seen <> ro_instance->latest_version( ).
      zcl_abapgit_persistence_user=>get_instance( )->set_repo_last_change_seen(
        iv_url     = lv_url
        iv_version = ro_instance->latest_version( ) ).
    ENDIF.

  ENDMETHOD.