  METHOD get_t100_text.

    SELECT SINGLE text
           FROM t100
           INTO rv_text
           WHERE arbgb = iv_msgid
           AND msgnr = iv_msgno
           AND sprsl = sy-langu.

  ENDMETHOD.