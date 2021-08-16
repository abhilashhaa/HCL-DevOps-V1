  METHOD get_ancestor_relations.

*    LOOP AT mt_relevant_relations ASSIGNING FIELD-SYMBOL(<ls_relation>).
*      IF <ls_relation>-node  =  iv_node AND
*         <ls_relation>-datub >= iv_datuv AND
*         <ls_relation>-datuv <= iv_datub.
*        APPEND <ls_relation> TO rt_ancestor_relations.
*      ENDIF.
*    ENDLOOP.

    LOOP AT mt_relevant_relations                         "begin 2790065
            ASSIGNING FIELD-SYMBOL(<ls_relation>)
            WHERE  node   =  iv_node AND
                   datuv <= iv_datub AND
                   datub >= iv_datuv.
        APPEND <ls_relation> TO rt_ancestor_relations.
    ENDLOOP.                                                "end 2790065

  ENDMETHOD.