  METHOD zif_abapgit_background~run.

    DATA: ls_files TYPE zif_abapgit_definitions=>ty_stage_files.

    mi_log = ii_log.
    ls_files = zcl_abapgit_factory=>get_stage_logic( )->get( io_repo ).

    IF lines( ls_files-local ) = 0 AND lines( ls_files-remote ) = 0.
      ii_log->add_info( 'Nothing to stage' ).
      RETURN.
    ENDIF.

    push_auto( io_repo ).

  ENDMETHOD.