  METHOD delete_docu_url.

    DATA lt_dm42s TYPE STANDARD TABLE OF dm42s WITH DEFAULT KEY.
    DATA ls_dm42s LIKE LINE OF lt_dm42s.

    SELECT *
      FROM dm42s
      INTO TABLE lt_dm42s
      WHERE entidto = me->mv_entity_id.

    LOOP AT lt_dm42s INTO ls_dm42s.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          langu    = me->mv_language
          obj_id   = 'URL1'
          key1     = ls_dm42s-entidto
          key2     = ls_dm42s-as4local
          key3     = ls_dm42s-entidfrom
          key4     = ls_dm42s-ebrolnr
        EXCEPTIONS
          ret_code = 0.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          langu    = me->mv_language
          obj_id   = 'URL2'
          key1     = ls_dm42s-entidto
          key2     = ls_dm42s-as4local
          key3     = ls_dm42s-entidfrom
          key4     = ls_dm42s-ebrolnr
        EXCEPTIONS
          ret_code = 0.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          langu    = me->mv_language
          obj_id   = 'URLC'
          key1     = ls_dm42s-entidto
          key2     = ls_dm42s-as4local
          key3     = ls_dm42s-entidfrom
          key4     = ls_dm42s-ebrolnr
        EXCEPTIONS
          ret_code = 0.

    ENDLOOP.


  ENDMETHOD.