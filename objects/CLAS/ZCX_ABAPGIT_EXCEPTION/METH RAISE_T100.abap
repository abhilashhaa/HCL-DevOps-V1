  METHOD raise_t100.
    DATA: ls_t100_key TYPE scx_t100key.

    ls_t100_key-msgid = iv_msgid.
    ls_t100_key-msgno = iv_msgno.
    ls_t100_key-attr1 = 'MSGV1'.
    ls_t100_key-attr2 = 'MSGV2'.
    ls_t100_key-attr3 = 'MSGV3'.
    ls_t100_key-attr4 = 'MSGV4'.

    IF iv_msgid IS INITIAL.
      CLEAR ls_t100_key.
    ENDIF.

    RAISE EXCEPTION TYPE zcx_abapgit_exception
      EXPORTING
        textid = ls_t100_key
        msgv1  = iv_msgv1
        msgv2  = iv_msgv2
        msgv3  = iv_msgv3
        msgv4  = iv_msgv4.
  ENDMETHOD.