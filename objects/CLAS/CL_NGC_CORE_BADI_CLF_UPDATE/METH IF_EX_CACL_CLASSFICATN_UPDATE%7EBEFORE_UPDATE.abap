  METHOD if_ex_cacl_classficatn_update~before_update.
    mv_new_date = iv_new_date.

    LOOP AT it_kssk_insert INTO DATA(ls_kssk).
      APPEND ls_kssk TO mt_kssk_ins.
    ENDLOOP.

    LOOP AT it_kssk_delete INTO ls_kssk.
      APPEND ls_kssk TO mt_kssk_del.
    ENDLOOP.

    LOOP AT it_kssk_update INTO ls_kssk.
      APPEND ls_kssk TO mt_kssk_upd.
    ENDLOOP.

  ENDMETHOD.