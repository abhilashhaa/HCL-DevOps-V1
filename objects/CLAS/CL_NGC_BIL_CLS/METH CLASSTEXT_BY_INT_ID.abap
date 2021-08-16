  METHOD CLASSTEXT_BY_INT_ID.

    SELECT * FROM i_clfnclasstextforkeydatetp( p_keydate = @iv_keydate )
      WHERE classinternalid = @iv_classinternalid
      INTO TABLE @rt_classtext.

  ENDMETHOD.