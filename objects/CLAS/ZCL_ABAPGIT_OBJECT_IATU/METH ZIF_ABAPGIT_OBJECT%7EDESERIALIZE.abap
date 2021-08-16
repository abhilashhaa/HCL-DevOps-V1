  METHOD zif_abapgit_object~deserialize.

    DATA: ls_attr   TYPE w3tempattr,
          lv_source TYPE string.


    io_xml->read( EXPORTING iv_name = 'ATTR'
                  CHANGING cg_data = ls_attr ).

    lv_source = mo_files->read_string( 'html' ).

    ls_attr-devclass = iv_package.
    save( is_attr   = ls_attr
          iv_source = lv_source ).

  ENDMETHOD.