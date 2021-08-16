  METHOD serialize_short_texts.

    DATA lt_udmo_texts TYPE STANDARD TABLE OF ty_udmo_text_type WITH DEFAULT KEY.
    " You are reminded that administrative information, such as last changed by user, date, time is not serialised.

    " You are reminded that active short texts of all (existent) languages are serialised.

    SELECT sprache dmoid as4local langbez
      FROM dm40t
      INTO CORRESPONDING FIELDS OF TABLE lt_udmo_texts
      WHERE dmoid    = me->mv_data_model
      AND   as4local = me->mv_activation_state
      ORDER BY sprache ASCENDING.                       "#EC CI_NOFIRST

    " You are reminded that descriptions in other languages do not have to be in existence.
    IF lines( lt_udmo_texts ) > 0.
      io_xml->add( iv_name = 'UDMO_TEXTS'
                   ig_data = lt_udmo_texts ).
    ENDIF.


  ENDMETHOD.