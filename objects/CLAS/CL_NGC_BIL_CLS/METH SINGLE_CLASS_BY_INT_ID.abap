  METHOD SINGLE_CLASS_BY_INT_ID.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @iv_keydate )
      WHERE classinternalid = @iv_classinternalid
      INTO @rs_class.

  ENDMETHOD.