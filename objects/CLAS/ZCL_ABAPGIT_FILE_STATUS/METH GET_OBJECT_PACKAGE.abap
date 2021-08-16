  METHOD get_object_package.
    DATA: lv_name    TYPE devclass,
          li_package TYPE REF TO zif_abapgit_sap_package.

    rv_devclass = zcl_abapgit_factory=>get_tadir( )->get_object_package(
      iv_object   = iv_object
      iv_obj_name = iv_obj_name ).
    IF rv_devclass IS INITIAL AND iv_object = 'DEVC' AND iv_obj_name(1) = '$'.
      " local packages usually have no tadir entry
      lv_name = iv_obj_name.
      li_package = zcl_abapgit_factory=>get_sap_package( lv_name ).
      IF li_package->exists( ) = abap_true.
        rv_devclass = lv_name.
      ENDIF.
    ENDIF.
  ENDMETHOD.