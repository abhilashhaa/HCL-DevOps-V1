  METHOD SINGLE_CLASS_BY_EXT_ID.

    SELECT SINGLE * FROM i_clfnclassforkeydatetp( p_keydate = @iv_keydate )
      WHERE class     = @iv_class
      AND   classtype = @iv_classtype
      INTO @rs_class ##WARN_OK.

  ENDMETHOD.