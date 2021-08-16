  METHOD zif_abapgit_object~serialize.

    DATA: ls_attr       TYPE w3servattr,
          lt_parameters TYPE w3servpara_tabletype.


    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    read( IMPORTING es_attr       = ls_attr
                    et_parameters = lt_parameters ).

    io_xml->add( iv_name = 'ATTR'
                 ig_data = ls_attr ).
    io_xml->add( iv_name = 'PARAMETERS'
                 ig_data = lt_parameters ).

  ENDMETHOD.