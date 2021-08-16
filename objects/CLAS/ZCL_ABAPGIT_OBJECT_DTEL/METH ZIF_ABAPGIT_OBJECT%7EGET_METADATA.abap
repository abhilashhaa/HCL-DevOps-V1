  METHOD zif_abapgit_object~get_metadata.
    rs_metadata = get_metadata( ).
    rs_metadata-ddic = abap_true.
  ENDMETHOD.