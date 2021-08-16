  METHOD update_record.
    DATA ls_relation TYPE ngc_clhier_idx.

    ls_relation-klart    = iv_klart.
    ls_relation-node     = iv_node.
    ls_relation-ancestor = iv_ancestor.
    ls_relation-datuv    = iv_datuv.
    ls_relation-datub    = iv_datub.
    ls_relation-aennr    = iv_aennr.

    READ TABLE mt_clhier_idx_update
      TRANSPORTING NO FIELDS
      WITH KEY
        klart    = iv_klart
        node     = iv_node
        ancestor = iv_ancestor
        datuv    = iv_datuv
        datub    = iv_datub
        aennr    = iv_aennr
      BINARY SEARCH.                                            "2739754

    IF sy-subrc <> 0.
      INSERT ls_relation INTO mt_clhier_idx_update INDEX sy-tabix. "2739754
*      APPEND ls_relation TO mt_clhier_idx_update.
    ENDIF.

*    READ TABLE mt_relevant_relations
*      ASSIGNING FIELD-SYMBOL(<ls_relevant_relation>)
*      WITH KEY
*        node     = ls_relation-node
*        ancestor = ls_relation-ancestor
*        datuv    = ls_relation-datuv
*      BINARY SEARCH.                                            "2739754

    READ TABLE mt_relevant_relations                          "begin 2790065
      ASSIGNING FIELD-SYMBOL(<ls_relevant_relation>)
      WITH TABLE KEY
        node     = ls_relation-node
        ancestor = ls_relation-ancestor
        datuv    = ls_relation-datuv.

    IF sy-subrc = 0.
      <ls_relevant_relation>-datub = ls_relation-datub.
      <ls_relevant_relation>-klart = ls_relation-klart.
      <ls_relevant_relation>-aennr = ls_relation-aennr.
    ENDIF.
  ENDMETHOD.