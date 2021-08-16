  METHOD zif_abapgit_object~get_metadata.
    rs_metadata = get_metadata( ).
* Data elements can refer to PARA objects
    rs_metadata-ddic = abap_true.
  ENDMETHOD.