  METHOD zif_abapgit_object~get_metadata.
    rs_metadata = get_metadata( ).

    rs_metadata-delete_tadir = abap_true.
    rs_metadata-late_deser   = abap_true.
  ENDMETHOD.