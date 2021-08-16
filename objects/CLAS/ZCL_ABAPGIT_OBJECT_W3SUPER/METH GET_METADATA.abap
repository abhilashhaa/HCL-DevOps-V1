  METHOD get_metadata.
    rs_metadata              = super->get_metadata( ).
    rs_metadata-version      = 'v2.0.0'. " Serialization v2, separate data file
    rs_metadata-delete_tadir = abap_true.
  ENDMETHOD.