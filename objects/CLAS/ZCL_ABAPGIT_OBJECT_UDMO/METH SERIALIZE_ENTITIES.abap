  METHOD serialize_entities.

    DATA lt_udmo_entities TYPE STANDARD TABLE OF dm41s WITH DEFAULT KEY.
    FIELD-SYMBOLS <ls_udmo_entity> TYPE dm41s.

    SELECT * FROM dm41s
      INTO TABLE lt_udmo_entities
      WHERE dmoid = me->mv_data_model
      AND as4local = me->mv_activation_state.


    LOOP AT lt_udmo_entities ASSIGNING <ls_udmo_entity>.

      " You are reminded that administrative information, such as last changed by user, date, time is not serialised.
      CLEAR <ls_udmo_entity>-lstuser.
      CLEAR <ls_udmo_entity>-lstdate.
      CLEAR <ls_udmo_entity>-lsttime.
      CLEAR <ls_udmo_entity>-fstuser.
      CLEAR <ls_udmo_entity>-fstdate.
      CLEAR <ls_udmo_entity>-fsttime.

    ENDLOOP.

    " You are reminded that descriptions in other languages do not have to be in existence, although they may.
    IF lines( lt_udmo_entities ) > 0.
      io_xml->add( iv_name = 'UDMO_ENTITIES'
                   ig_data = lt_udmo_entities ).
    ENDIF.

  ENDMETHOD.