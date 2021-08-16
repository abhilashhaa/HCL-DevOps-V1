  METHOD deserialize.

    DATA: lt_updated_files TYPE zif_abapgit_definitions=>ty_file_signatures_tt,
          lx_error         TYPE REF TO zcx_abapgit_exception.

    find_remote_dot_abapgit( ).
    find_remote_dot_apack( ).

    check_write_protect( ).
    check_language( ).

    IF is_checks-requirements-met = zif_abapgit_definitions=>gc_no AND is_checks-requirements-decision IS INITIAL.
      zcx_abapgit_exception=>raise( 'Requirements not met and undecided' ).
    ENDIF.

    IF is_checks-dependencies-met = zif_abapgit_definitions=>gc_no.
      zcx_abapgit_exception=>raise( 'APACK dependencies not met' ).
    ENDIF.

    IF is_checks-transport-required = abap_true AND is_checks-transport-transport IS INITIAL.
      zcx_abapgit_exception=>raise( |No transport request was supplied| ).
    ENDIF.

    TRY.
        lt_updated_files = zcl_abapgit_objects=>deserialize(
            io_repo   = me
            is_checks = is_checks
            ii_log    = ii_log ).
      CATCH zcx_abapgit_exception INTO lx_error.
* ensure to reset default transport request task
        zcl_abapgit_default_transport=>get_instance( )->reset( ).
        RAISE EXCEPTION lx_error.
    ENDTRY.

    APPEND get_dot_abapgit( )->get_signature( ) TO lt_updated_files.

    CLEAR: mt_local.

    update_local_checksums( lt_updated_files ).
    update_last_deserialize( ).
    reset_status( ).

    COMMIT WORK AND WAIT.

    check_for_restart( ).

  ENDMETHOD.