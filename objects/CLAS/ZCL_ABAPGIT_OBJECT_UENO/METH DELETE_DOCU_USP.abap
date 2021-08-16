  METHOD delete_docu_usp.

    DATA lt_dm45l TYPE STANDARD TABLE OF dm45l WITH DEFAULT KEY.
    DATA ls_dm45l LIKE LINE OF lt_dm45l.

    SELECT *
      FROM dm45l
      INTO TABLE lt_dm45l
      WHERE entid = me->ms_item-obj_name.

    LOOP AT lt_dm45l INTO ls_dm45l.

      CALL FUNCTION 'SDU_DOCU_DELETE'
        EXPORTING
          langu    = me->mv_language
          obj_id   = 'USPD'
          key1     = ls_dm45l-entid
          key2     = ls_dm45l-as4local
          key3     = ls_dm45l-spezid
        EXCEPTIONS
          ret_code = 0.

    ENDLOOP.


  ENDMETHOD.