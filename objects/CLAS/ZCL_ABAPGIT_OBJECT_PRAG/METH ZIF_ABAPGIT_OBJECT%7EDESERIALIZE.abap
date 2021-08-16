  METHOD zif_abapgit_object~deserialize.

    DATA: ls_pragma TYPE ty_pragma,
          lo_pragma TYPE REF TO cl_abap_pragma.

    TRY.
        io_xml->read(
          EXPORTING
            iv_name = 'PRAG'
          CHANGING
            cg_data = ls_pragma ).

        lo_pragma = cl_abap_pragma=>create( p_pragma  = ms_item-obj_name
                                            p_package = iv_package ).

        lo_pragma->set_info( p_description = ls_pragma-description
                             p_signature   = ls_pragma-signature
                             p_extension   = ls_pragma-extension ).

        lo_pragma->save( ).

      CATCH cx_abap_pragma_not_exists.
        _raise_pragma_not_exists( ).
      CATCH cx_abap_pragma_exists.
        _raise_pragma_exists( ).
      CATCH cx_abap_pragma_enqueue.
        _raise_pragma_enqueue( ).
    ENDTRY.

  ENDMETHOD.