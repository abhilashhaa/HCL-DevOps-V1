  METHOD zif_abapgit_stage_logic~get.

    rs_files-local  = io_repo->get_files_local( ).
    rs_files-remote = io_repo->get_files_remote( ).
    rs_files-status = io_repo->status( ).
    remove_identical( CHANGING cs_files = rs_files ).
    remove_ignored( EXPORTING io_repo  = io_repo
                    CHANGING  cs_files = rs_files ).

  ENDMETHOD.