  METHOD deserialize_entities.

    DATA lt_udmo_entities TYPE STANDARD TABLE OF dm41s WITH DEFAULT KEY.
    DATA ls_udmo_entity LIKE LINE OF lt_udmo_entities.


    io_xml->read( EXPORTING iv_name = 'UDMO_ENTITIES'
                  CHANGING  cg_data = lt_udmo_entities ).

    LOOP AT lt_udmo_entities INTO ls_udmo_entity.

      CALL FUNCTION 'SDU_DMO_ENT_PUT'
        EXPORTING
          object   = ls_udmo_entity
        EXCEPTIONS
          ret_code = 0
          OTHERS   = 0.

    ENDLOOP.

  ENDMETHOD.