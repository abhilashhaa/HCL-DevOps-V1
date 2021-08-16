  METHOD get_valid_relations.

*    LOOP AT mt_relevant_relations ASSIGNING FIELD-SYMBOL(<ls_relation>).
*      IF <ls_relation>-node     =  iv_node AND
*         <ls_relation>-ancestor =  iv_ancestor AND
*         <ls_relation>-datub    >= iv_datuv AND
*         <ls_relation>-datuv    <= iv_datub.
*        APPEND <ls_relation> TO rt_relations.
*      ENDIF.
*    ENDLOOP.

    LOOP AT mt_relevant_relations                         "2790065
        ASSIGNING FIELD-SYMBOL(<ls_relation>)
       WHERE
          node     =  iv_node AND
          ancestor =  iv_ancestor AND
          datuv    <= iv_datub AND
          datub    >= iv_datuv.
        APPEND <ls_relation> TO rt_relations.
*      ENDIF.
    ENDLOOP.


  ENDMETHOD.