  METHOD zif_abapgit_object~serialize.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    serialize_model( io_xml ).
    me->serialize_entities( io_xml ).
    me->serialize_short_texts( io_xml ).
    me->serialize_long_texts( io_xml ).

  ENDMETHOD.