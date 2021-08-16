  METHOD clear_fields.

    FIELD-SYMBOLS <ls_node> LIKE LINE OF ct_nodes.

    CLEAR: cs_head-luser, cs_head-ldate, cs_head-ltime.
    CLEAR: cs_head-fuser, cs_head-fdate, cs_head-ftime.
    CLEAR: cs_head-frelease, cs_head-lrelease.
    CLEAR: cs_head-responsibl.

    LOOP AT ct_nodes ASSIGNING <ls_node>.
      CLEAR: <ls_node>-luser, <ls_node>-ldate, <ls_node>-ltime.
      CLEAR: <ls_node>-fuser, <ls_node>-fdate, <ls_node>-ftime.
      CLEAR: <ls_node>-frelease, <ls_node>-lrelease.
    ENDLOOP.

  ENDMETHOD.