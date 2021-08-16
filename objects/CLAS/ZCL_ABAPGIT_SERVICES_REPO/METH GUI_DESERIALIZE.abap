  METHOD gui_deserialize.

    DATA: ls_checks       TYPE zif_abapgit_definitions=>ty_deserialize_checks,
          lt_requirements TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt,
          lt_dependencies TYPE zif_abapgit_apack_definitions=>tt_dependencies.


* find troublesome objects
    ls_checks = io_repo->deserialize_checks( ).

* and let the user decide what to do
    TRY.
        popup_overwrite( CHANGING ct_overwrite = ls_checks-overwrite ).
        popup_package_overwrite( CHANGING ct_overwrite = ls_checks-warning_package ).

        IF ls_checks-requirements-met = zif_abapgit_definitions=>gc_no.
          lt_requirements = io_repo->get_dot_abapgit( )->get_data( )-requirements.
          zcl_abapgit_requirement_helper=>requirements_popup( lt_requirements ).
          ls_checks-requirements-decision = zif_abapgit_definitions=>gc_yes.
        ENDIF.

        IF ls_checks-dependencies-met = zif_abapgit_definitions=>gc_no.
          lt_dependencies = io_repo->get_dot_apack( )->get_manifest_descriptor( )-dependencies.
          zcl_abapgit_apack_helper=>dependencies_popup( lt_dependencies ).
        ENDIF.

        IF ls_checks-transport-required = abap_true.
          ls_checks-transport-transport = zcl_abapgit_ui_factory=>get_popups( )->popup_transport_request(
            is_transport_type = ls_checks-transport-type ).
        ENDIF.

      CATCH zcx_abapgit_cancel.
        RETURN.
    ENDTRY.

* and pass decisions to deserialize
    io_repo->deserialize( is_checks = ls_checks
                          ii_log    = io_repo->create_new_log( 'Pull Log' ) ).

  ENDMETHOD.