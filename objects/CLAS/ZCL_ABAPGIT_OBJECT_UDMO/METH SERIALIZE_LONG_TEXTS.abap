  METHOD serialize_long_texts.

    " The model has short texts in multiple languages. These are held in DM40T.

    " The model has a long description also in a master language, with other long descriptions
    " maintained as translations using SE63 Translation Editor. All of these long texts are held in DOK*

    TYPES BEGIN OF ls_language_type.
    TYPES language TYPE dm40t-sprache.
    TYPES END OF ls_language_type.

    DATA BEGIN OF ls_udmo_long_text.
    DATA language TYPE dm40t-sprache.
    DATA header   TYPE thead.
    DATA content TYPE xstring.
    DATA END OF ls_udmo_long_text.

    DATA lt_udmo_long_texts LIKE STANDARD TABLE OF ls_udmo_long_text.
    DATA lt_udmo_languages TYPE STANDARD TABLE OF ls_language_type.
    DATA ls_udmo_language  LIKE LINE OF lt_udmo_languages.
    DATA: lv_error_status  TYPE lxestatprc.


    " In which languages are the short texts are maintained.
    SELECT sprache AS language
      FROM dm40t
      INTO TABLE lt_udmo_languages
      WHERE dmoid    = me->mv_data_model
      AND   as4local = me->mv_activation_state
      ORDER BY sprache ASCENDING.                       "#EC CI_NOFIRST

    " For every language for which a short text is maintained,
    LOOP AT lt_udmo_languages INTO ls_udmo_language.

      CLEAR ls_udmo_long_text.
      CLEAR lv_error_status.

      ls_udmo_long_text-language = ls_udmo_language-language.

      " You are reminded that this function gets the most recent version of the texts.
      CALL FUNCTION 'LXE_OBJ_DOKU_GET_XSTRING'
        EXPORTING
          lang    = ls_udmo_language-language
          objtype = me->c_lxe_text_type
          objname = me->mv_lxe_text_name
        IMPORTING
          header  = ls_udmo_long_text-header
          content = ls_udmo_long_text-content
          pstatus = lv_error_status.

      CHECK lv_error_status = 'S'. "Success

      " Administrative information is not serialised
      CLEAR ls_udmo_long_text-header-tdfuser.
      CLEAR ls_udmo_long_text-header-tdfdate.
      CLEAR ls_udmo_long_text-header-tdftime.

      CLEAR ls_udmo_long_text-header-tdluser.
      CLEAR ls_udmo_long_text-header-tdldate.
      CLEAR ls_udmo_long_text-header-tdltime.

      APPEND ls_udmo_long_text TO lt_udmo_long_texts.

    ENDLOOP.

    " You are reminded that long texts do not have to be in existence
    IF lines( lt_udmo_long_texts ) > 0.
      io_xml->add( iv_name = 'UDMO_LONG_TEXTS'
                   ig_data = lt_udmo_long_texts ).
    ENDIF.


  ENDMETHOD.