  METHOD deserialize_long_texts.

    DATA BEGIN OF ls_udmo_long_text.
    DATA language TYPE dm40t-sprache.
    DATA header   TYPE thead.
    DATA content TYPE xstring.
    DATA END OF ls_udmo_long_text.

    DATA lt_udmo_long_texts LIKE STANDARD TABLE OF ls_udmo_long_text.
    DATA ls_header TYPE thead.

    io_xml->read( EXPORTING iv_name = 'UDMO_LONG_TEXTS'
                  CHANGING  cg_data = lt_udmo_long_texts ).

    LOOP AT lt_udmo_long_texts INTO ls_udmo_long_text.

      ls_udmo_long_text-header-tdfuser = sy-uname.
      ls_udmo_long_text-header-tdfdate = sy-datum.
      ls_udmo_long_text-header-tdftime = sy-uzeit.

      " You are reminded that the target system may already have some texts in
      " existence. So we determine the highest existent version.

      CLEAR ls_header-tdversion.

      SELECT MAX( dokversion )
      INTO ls_header-tdversion
      FROM dokhl
      WHERE id = me->c_lxe_text_type
      AND   object = me->mv_text_object
      AND   langu = ls_udmo_long_text-language.

      " Increment the version
      ls_header-tdversion = ls_header-tdversion + 1.
      ls_udmo_long_text-header-tdversion = ls_header-tdversion.

      " This function module takes care of the variation in text processing between various objects.
      CALL FUNCTION 'LXE_OBJ_DOKU_PUT_XSTRING'
        EXPORTING
          slang   = me->mv_language
          tlang   = ls_udmo_long_text-language
          objtype = me->c_lxe_text_type
          objname = me->mv_lxe_text_name
          header  = ls_udmo_long_text-header
          content = ls_udmo_long_text-content.


    ENDLOOP.


  ENDMETHOD.