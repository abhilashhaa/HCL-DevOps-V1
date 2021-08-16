  METHOD delete_ausp.

    DATA:
      lv_del_whr TYPE string VALUE '',
      lv_num     TYPE i      VALUE 0.

    rt_num_del_entries = 0.

    LOOP AT it_delete_ausp REFERENCE INTO DATA(lr_delete_ausp).

      " Having one DELETE statement per line would not be so performant, therefore we join as much as we can into one DELETE.
      IF lv_num > 0.
        lv_del_whr = lv_del_whr && ` OR `.
      ENDIF.

      lv_del_whr = lv_del_whr && `(objek = '` && lr_delete_ausp->objek && `' AND klart = '` && lr_delete_ausp->klart && `' AND atinn = ` && lr_delete_ausp->atinn && `)` ##NO_TEXT.
      lv_num += 1.

      IF lv_num > mv_3_cond_p_line_limit.
        lv_del_whr = `(` && lv_del_whr && `)`.
        DELETE FROM ausp WHERE (lv_del_whr) AND mafid = 'O'. "#EC CI_DYNWHERE
        rt_num_del_entries += sy-dbcnt.
        lv_del_whr = ''.
        lv_num     = 0.
      ENDIF.
    ENDLOOP.

    IF lv_num > 0.
      lv_del_whr = `(` && lv_del_whr && `)`.
      DELETE FROM ausp WHERE (lv_del_whr) AND mafid = 'O'. "#EC CI_DYNWHERE
      rt_num_del_entries += sy-dbcnt.
      lv_del_whr = ''.
      lv_num     = 0.
    ENDIF.

  ENDMETHOD.