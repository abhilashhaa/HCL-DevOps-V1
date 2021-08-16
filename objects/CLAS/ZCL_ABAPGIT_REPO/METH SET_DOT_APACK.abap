  METHOD set_dot_apack.
    get_dot_apack( ).
    mo_apack_reader->set_manifest_descriptor( io_dot_apack->get_manifest_descriptor( ) ).
  ENDMETHOD.