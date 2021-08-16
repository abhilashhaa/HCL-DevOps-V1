  METHOD is_charc_resticted.

    SELECT * FROM i_clfncharcrstrcnforkeydatetp( p_keydate = @sy-datum )
      WHERE  charcinternalid = @iv_charcinternalid
      INTO TABLE @DATA(lt_charcrestriction).
    IF sy-dbcnt <> 0.
      IF NOT line_exists( lt_charcrestriction[ classtype = iv_classtype ] ).
        rv_result = abap_true. "cannot be used with iv_classtype
      ENDIF.
    ENDIF.

  ENDMETHOD.