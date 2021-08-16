  METHOD zif_abapgit_object~serialize.

    DATA: ls_attr   TYPE w3tempattr,
          lv_source TYPE string.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    read( IMPORTING es_attr   = ls_attr
                    ev_source = lv_source ).

    io_xml->add( iv_name = 'ATTR'
                 ig_data = ls_attr ).

    mo_files->add_string( iv_ext    = 'html'
                          iv_string = lv_source ).

  ENDMETHOD.