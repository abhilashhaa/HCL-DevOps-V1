  METHOD zif_abapgit_object~serialize.

    DATA: lo_pragma TYPE REF TO cl_abap_pragma,
          ls_pragma TYPE ty_pragma.

    TRY.
        lo_pragma = cl_abap_pragma=>get_ref( ms_item-obj_name ).

        ls_pragma-pragma      = lo_pragma->pragma.
        ls_pragma-extension   = lo_pragma->extension.
        ls_pragma-signature   = lo_pragma->signature.
        ls_pragma-description = lo_pragma->description.

        io_xml->add( iv_name = 'PRAG'
                     ig_data = ls_pragma ).

      CATCH cx_abap_pragma_not_exists.
        _raise_pragma_not_exists( ).
    ENDTRY.

  ENDMETHOD.