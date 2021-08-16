  METHOD get_valid_relation.
*    LOOP AT mt_relevant_relations ASSIGNING FIELD-SYMBOL(<ls_relation>).
*      IF <ls_relation>-node     =  iv_node AND
*         <ls_relation>-ancestor =  iv_ancestor AND
*         <ls_relation>-datub    >= iv_datuv AND
*         <ls_relation>-datuv    <= iv_datub.
*        rs_relation = <ls_relation>.
*        RETURN.
*      ENDIF.
*    ENDLOOP.
    LOOP AT mt_relevant_relations
        ASSIGNING FIELD-SYMBOL(<ls_relation>) "2790065
        USING KEY primary_key
              WHERE
                node     =  iv_node AND
                ancestor =  iv_ancestor AND
                datuv    <= iv_datub AND
                datub    >= iv_datuv.

        rs_relation = <ls_relation>.
        RETURN.
*      ENDIF.
    ENDLOOP.
  ENDMETHOD.