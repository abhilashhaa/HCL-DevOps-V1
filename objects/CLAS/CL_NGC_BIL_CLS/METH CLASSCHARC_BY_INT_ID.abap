  METHOD CLASSCHARC_BY_INT_ID.

    SELECT * FROM i_clfnclasscharcforkeydatetp( p_keydate = @iv_keydate )
      WHERE classinternalid = @iv_classinternalid
      INTO TABLE @rt_classcharc.

  ENDMETHOD.