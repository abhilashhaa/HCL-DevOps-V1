  METHOD zif_abapgit_oo_object_fnc~read_sotr.
    zcl_abapgit_sotr_handler=>read_sotr(
      iv_pgmid    = 'LIMU'
      iv_object   = 'CPUB'
      iv_obj_name = iv_object_name
      io_xml      = ii_xml ).
  ENDMETHOD.