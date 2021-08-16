  METHOD zif_abapgit_object~serialize.

    CALL METHOD mo_plugin->('WRAP_SERIALIZE')
      EXPORTING
        io_xml = io_xml.

  ENDMETHOD.