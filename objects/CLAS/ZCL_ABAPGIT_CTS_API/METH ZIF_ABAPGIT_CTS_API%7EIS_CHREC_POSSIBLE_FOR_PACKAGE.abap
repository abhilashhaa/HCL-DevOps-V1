  METHOD zif_abapgit_cts_api~is_chrec_possible_for_package.
    rv_possible = zcl_abapgit_factory=>get_sap_package( iv_package )->are_changes_recorded_in_tr_req( ).
  ENDMETHOD.