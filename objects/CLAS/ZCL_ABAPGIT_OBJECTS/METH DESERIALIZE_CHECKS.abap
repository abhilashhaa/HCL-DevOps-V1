  METHOD deserialize_checks.

    DATA: lt_results TYPE zif_abapgit_definitions=>ty_results_tt,
          li_package TYPE REF TO zif_abapgit_sap_package.


    lt_results = files_to_deserialize( io_repo ).

    rs_checks-overwrite = warning_overwrite_find( lt_results ).

    rs_checks-warning_package = warning_package_find(
      io_repo    = io_repo
      it_results = lt_results ).

    IF lines( lt_results ) > 0.
      li_package = zcl_abapgit_factory=>get_sap_package( io_repo->get_package( ) ).
      rs_checks-transport-required = li_package->are_changes_recorded_in_tr_req( ).
      IF NOT rs_checks-transport-required IS INITIAL.
        rs_checks-transport-type = li_package->get_transport_type( ).
      ENDIF.
    ENDIF.

  ENDMETHOD.