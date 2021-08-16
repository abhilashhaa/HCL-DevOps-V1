  METHOD CLASSKEYWORD_BY_INT_ID.

    SELECT * FROM i_clfnclasskeywordforkeydatetp( p_keydate = @iv_keydate )
      WHERE classinternalid = @iv_classinternalid
      ORDER BY
        language,
        classkeywordpositionnumber
      INTO TABLE @rt_classkeyword.

  ENDMETHOD.