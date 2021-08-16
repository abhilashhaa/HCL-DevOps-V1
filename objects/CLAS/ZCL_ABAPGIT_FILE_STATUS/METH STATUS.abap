  METHOD status.

    DATA: lv_index       LIKE sy-tabix,
          lo_dot_abapgit TYPE REF TO zcl_abapgit_dot_abapgit,
          lt_local       TYPE zif_abapgit_definitions=>ty_files_item_tt.

    FIELD-SYMBOLS: <ls_result> LIKE LINE OF rt_results.

    lt_local = io_repo->get_files_local( ii_log = ii_log ).

    IF lines( lt_local ) <= 2.
      " Less equal two means that we have only the .abapgit.xml and the package in
      " our local repository. In this case we have to update our local .abapgit.xml
      " from the remote one. Otherwise we get errors when e.g. the folder starting
      " folder is different.
      io_repo->find_remote_dot_abapgit( ).
    ENDIF.

    rt_results = calculate_status(
      iv_devclass  = io_repo->get_package( )
      io_dot       = io_repo->get_dot_abapgit( )
      it_local     = io_repo->get_files_local( ii_log = ii_log )
      it_remote    = io_repo->get_files_remote( )
      it_cur_state = io_repo->get_local_checksums_per_file( ) ).

    lo_dot_abapgit = io_repo->get_dot_abapgit( ).

    " Remove ignored files, fix .abapgit
    LOOP AT rt_results ASSIGNING <ls_result>.
      lv_index = sy-tabix.

      IF lo_dot_abapgit->is_ignored(
          iv_path     = <ls_result>-path
          iv_filename = <ls_result>-filename ) = abap_true.
        DELETE rt_results INDEX lv_index.
      ENDIF.
    ENDLOOP.

    run_checks(
      ii_log     = ii_log
      it_results = rt_results
      io_dot     = lo_dot_abapgit
      iv_top     = io_repo->get_package( ) ).

  ENDMETHOD.