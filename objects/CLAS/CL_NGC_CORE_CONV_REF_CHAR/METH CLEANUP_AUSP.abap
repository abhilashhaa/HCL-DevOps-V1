METHOD cleanup_ausp.

  DATA:
    lv_del_whr TYPE string VALUE '',
    lv_num     TYPE i      VALUE 0.

  LOOP AT it_ausp ASSIGNING FIELD-SYMBOL(<ls_ausp>)
  GROUP BY ( objek = <ls_ausp>-objek  atinn = <ls_ausp>-atinn  klart = <ls_ausp>-klart ) WITHOUT MEMBERS
  ASSIGNING FIELD-SYMBOL(<ls_ausp_groupkey>).
    " Having one DELETE statement per line would not be so performant, therefore we join as much as we can into one DELETE.
    IF lv_num GT 0.
      lv_del_whr = lv_del_whr && ` OR `.
    ENDIF.
    lv_del_whr = lv_del_whr && `(objek = '` && <ls_ausp_groupkey>-objek && `' AND atinn = ` && <ls_ausp_groupkey>-atinn && ` AND klart = '` && <ls_ausp_groupkey>-klart && `')` ##NO_TEXT.
    ADD 1 TO lv_num.
    IF lv_num GT mv_3_cond_p_line_limit.
      lv_del_whr = `(` && lv_del_whr && `)`.
      DELETE FROM ausp WHERE (lv_del_whr) AND mafid = 'O'. "#EC CI_DYNWHERE
      lv_del_whr = ''.
      lv_num     = 0.
    ENDIF.
  ENDLOOP.
  IF lv_num GT 0.
    lv_del_whr = `(` && lv_del_whr && `)`.
    DELETE FROM ausp WHERE (lv_del_whr) AND mafid = 'O'. "#EC CI_DYNWHERE
    lv_del_whr = ''.
    lv_num     = 0.
  ENDIF.

ENDMETHOD.