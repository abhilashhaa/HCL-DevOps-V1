  METHOD delete_docu_uen.

    DATA lt_dm02l TYPE STANDARD TABLE OF dm02l WITH DEFAULT KEY.
    DATA ls_dm02l TYPE dm02l.

    SELECT *
      FROM dm02l
      INTO TABLE lt_dm02l
      WHERE entid = me->mv_entity_id.

    LOOP AT lt_dm02l INTO ls_dm02l.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          key1     = ls_dm02l-entid
          key2     = ls_dm02l-as4local
          key3     = '00'
          langu    = me->mv_language
          obj_id   = 'UENC' "Entity Comments
        EXCEPTIONS
          ret_code = 0.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          key1     = ls_dm02l-entid
          key2     = ls_dm02l-as4local
          key3     = '00'
          langu    = me->mv_language
          obj_id   = 'UEND' "Entity Definition
        EXCEPTIONS
          ret_code = 0.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          key1     = ls_dm02l-entid
          key2     = ls_dm02l-as4local
          key3     = '00'
          langu    = me->mv_language
          obj_id   = 'UENE' "Entity Example
        EXCEPTIONS
          ret_code = 0.

    ENDLOOP.

  ENDMETHOD.