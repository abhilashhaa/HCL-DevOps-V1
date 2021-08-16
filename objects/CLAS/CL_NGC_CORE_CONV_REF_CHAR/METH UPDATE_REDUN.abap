METHOD update_redun.

  DATA:
    lv_nodes_whr TYPE string VALUE ''.

  " We want to exclude the nodes, so first select the nodes.
  SELECT DISTINCT tclao1~klart, tclao1~obtab
    FROM tclao AS tclao1
    INNER JOIN tclao AS tclao2
       ON tclao1~klart = tclao2~klart
      AND tclao1~zaehl < tclao2~zaehl
    WHERE tclao1~zaehl <> '00'
  UNION
  SELECT DISTINCT tclao~klart, tclao~obtab
    FROM tclao AS tclao
    INNER JOIN tcla AS tcla
       ON tclao~klart = tcla~klart
    WHERE tclao~zaehl <> '00' AND tcla~varklart = 'X'
      AND ( tclao~obtab = 'MARA'
         OR tclao~obtab = 'ESLH'
         OR tclao~obtab = 'PLKONET'
         OR tclao~obtab = 'PLKOGMTL' )
  INTO TABLE @DATA(lt_node)
    BYPASSING BUFFER.

  LOOP AT lt_node ASSIGNING FIELD-SYMBOL(<ls_node>).
    IF lv_nodes_whr <> ''.
      lv_nodes_whr = lv_nodes_whr && ` OR `.
    ENDIF.
    lv_nodes_whr = lv_nodes_whr && `(klart = '` && <ls_node>-klart && `' AND obtab = '` && <ls_node>-obtab && `')` ##NO_TEXT.
  ENDLOOP.

  IF lv_nodes_whr = ''.
    UPDATE tclao SET redun = 'X' WHERE redun = ' '.
  ELSE.
    lv_nodes_whr = `(` && lv_nodes_whr && `)`.
    UPDATE tclao SET redun = 'X' WHERE redun = ' ' AND NOT (lv_nodes_whr). "#EC CI_DYNWHERE
  ENDIF.

  UPDATE tclt SET redun = 'X' WHERE redun = ' '.
  CALL FUNCTION 'DB_COMMIT'.

ENDMETHOD.