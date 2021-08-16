  METHOD zif_abapgit_oo_object_fnc~create_sotr.
    zcl_abapgit_sotr_handler=>create_sotr(
      iv_package = iv_package
      io_xml     = ii_xml ).
  ENDMETHOD.