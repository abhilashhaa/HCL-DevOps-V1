  METHOD update_existing_relations.
    DATA:
      ls_removable_relation  TYPE ngc_clhier_idx,
      lt_removable_relations TYPE ngct_clhier_idx.

    DATA(lt_relations_for_node) = it_relations_for_node.
    DATA(lt_relations_stored)   = it_relations_for_node.

    FIELD-SYMBOLS:
      <ls_relation> LIKE LINE OF lt_relations_for_node.

    LOOP AT lt_relations_for_node ASSIGNING FIELD-SYMBOL(<ls_relation_for_node>).
      <ls_relation_for_node>-datuv = '99991231'.
      <ls_relation_for_node>-datub = '00000000'.
    ENDLOOP.

    " Update the validity dates and pathes count values for all selected item.
    me->get_active_relations(
      EXPORTING
        iv_root_node = iv_root_node
      CHANGING
        ct_relations = lt_relations_for_node ).

    LOOP AT lt_relations_for_node ASSIGNING <ls_relation>.
      IF NOT ( <ls_relation>-datuv = '99991231' AND <ls_relation>-datub = '00000000' ).
        DELETE lt_relations_stored
          WHERE
            node     = <ls_relation>-node AND
            ancestor = <ls_relation>-ancestor AND
            datuv    = <ls_relation>-datuv.

*        READ TABLE mt_relevant_relations
*          TRANSPORTING NO FIELDS
*          WITH KEY
*            node     = <ls_relation>-node
*            ancestor = <ls_relation>-ancestor
*            datuv    = <ls_relation>-datuv
*            BINARY SEARCH.                                      "2739754

        READ TABLE mt_relevant_relations                        "2790065
          TRANSPORTING NO FIELDS
          WITH TABLE KEY
            node     = <ls_relation>-node
            ancestor = <ls_relation>-ancestor
            datuv    = <ls_relation>-datuv.

        IF sy-subrc = 0.
          " Update the updated relation.
          me->update_record(
            iv_klart    = <ls_relation>-klart
            iv_node     = <ls_relation>-node
            iv_ancestor = <ls_relation>-ancestor
            iv_datuv    = <ls_relation>-datuv
            iv_datub    = <ls_relation>-datub
            iv_aennr    = <ls_relation>-aennr ).
        ELSE.
          " Insert the updated relation.
          me->insert_record(
            iv_klart    = <ls_relation>-klart
            iv_node     = <ls_relation>-node
            iv_ancestor = <ls_relation>-ancestor
            iv_datuv    = <ls_relation>-datuv
            iv_datub    = <ls_relation>-datub
            iv_aennr    = <ls_relation>-aennr ).
        ENDIF.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_relations_stored ASSIGNING <ls_relation>.
      me->delete_record(
        iv_node     = <ls_relation>-node
        iv_ancestor = <ls_relation>-ancestor
        iv_datuv    = <ls_relation>-datuv ).
    ENDLOOP.
  ENDMETHOD.