  METHOD zif_abapgit_object~get_metadata.
    rs_metadata = get_metadata( ).
    rs_metadata-delete_tadir = abap_true.
    rs_metadata-version = 'v2.0.0'.
  ENDMETHOD.