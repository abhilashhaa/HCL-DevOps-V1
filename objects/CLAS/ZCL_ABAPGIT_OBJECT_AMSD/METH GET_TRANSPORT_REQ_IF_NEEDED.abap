  METHOD get_transport_req_if_needed.

    DATA: li_sap_package TYPE REF TO zif_abapgit_sap_package.

    li_sap_package = zcl_abapgit_factory=>get_sap_package( iv_package ).

    IF li_sap_package->are_changes_recorded_in_tr_req( ) = abap_true.
      rv_transport_request = zcl_abapgit_default_transport=>get_instance( )->get( )-ordernum.
    ENDIF.

  ENDMETHOD.