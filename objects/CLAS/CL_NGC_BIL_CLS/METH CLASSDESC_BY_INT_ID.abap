  METHOD CLASSDESC_BY_INT_ID.

    SELECT * FROM i_clfnclassdescforkeydatetp( p_keydate = @iv_keydate )
      WHERE classinternalid = @iv_classinternalid
      INTO TABLE @rt_classdesc.

  ENDMETHOD.