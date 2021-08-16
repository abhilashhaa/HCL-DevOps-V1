  METHOD zif_abapgit_object~deserialize.

    DATA: ls_attr TYPE w3tempattr.


    io_xml->read( EXPORTING iv_name = 'ATTR'
                  CHANGING  cg_data = ls_attr ).

    ls_attr-devclass = iv_package.

    IF zif_abapgit_object~exists( ) = abap_true.
      zif_abapgit_object~delete( iv_package ).
    ENDIF.

    save( is_attr = ls_attr ).

  ENDMETHOD.