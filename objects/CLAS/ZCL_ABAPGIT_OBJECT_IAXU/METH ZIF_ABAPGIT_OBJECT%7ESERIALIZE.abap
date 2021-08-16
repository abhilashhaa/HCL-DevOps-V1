  METHOD zif_abapgit_object~serialize.

    DATA: ls_attr TYPE w3tempattr.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    ls_attr = read( ).

    io_xml->add( iv_name = 'ATTR'
                 ig_data = ls_attr ).

  ENDMETHOD.