  METHOD deserialize_short_texts.

    DATA lt_udmo_texts TYPE STANDARD TABLE OF ty_udmo_text_type WITH DEFAULT KEY.
    DATA ls_udmo_text  TYPE ty_udmo_text_type.
    DATA ls_dm40t TYPE dm40t.


    " Deserialize the XML
    io_xml->read( EXPORTING iv_name = 'UDMO_TEXTS'
                  CHANGING  cg_data = lt_udmo_texts ).

    " For every text provided
    LOOP AT lt_udmo_texts INTO ls_udmo_text.

      " Does the text already exist? This is the same logic as used
      " in the FM SDU_MODEL_PUT
      SELECT SINGLE *
        FROM dm40t
        INTO ls_dm40t
        WHERE sprache  = ls_udmo_text-sprache
        AND   dmoid    = ls_udmo_text-dmoid
        AND   as4local = me->mv_activation_state.

      IF sy-subrc = 0.
        " There is already an active description for this language
        " but the provided description differs
        IF ls_dm40t-langbez <> ls_udmo_text-langbez.

          ls_dm40t-langbez = ls_udmo_text-langbez.
          ls_dm40t-lstdate = sy-datum.
          ls_dm40t-lsttime = sy-uzeit.
          ls_dm40t-lstuser = sy-uname.

          MODIFY dm40t FROM ls_dm40t.

        ENDIF.
      ELSE.

        " There is no EXISTING active description in this language

        ls_dm40t-as4local = ls_udmo_text-as4local.
        ls_dm40t-dmoid    = ls_udmo_text-dmoid.
        ls_dm40t-langbez  = ls_udmo_text-langbez.
        ls_dm40t-lstdate  = sy-datum.
        ls_dm40t-lsttime  = sy-uzeit.
        ls_dm40t-lstuser  = sy-uname.
        ls_dm40t-sprache  = ls_udmo_text-sprache.


        INSERT dm40t FROM ls_dm40t.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.