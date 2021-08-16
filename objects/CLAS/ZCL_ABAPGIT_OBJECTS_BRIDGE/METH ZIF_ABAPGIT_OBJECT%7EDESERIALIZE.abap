  METHOD zif_abapgit_object~deserialize.

    DATA: lx_plugin        TYPE REF TO cx_static_check.

    TRY.
        CALL METHOD mo_plugin->('WRAP_DESERIALIZE')
          EXPORTING
            iv_package = iv_package
            io_xml     = io_xml.
      CATCH cx_static_check INTO lx_plugin.
        zcx_abapgit_exception=>raise( lx_plugin->get_text( ) ).
    ENDTRY.
  ENDMETHOD.