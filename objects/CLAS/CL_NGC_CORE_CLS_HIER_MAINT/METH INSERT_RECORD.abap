  METHOD insert_record.
    DATA:                                                 "begin 2739754
        ls_relation TYPE ngc_clhier_idx.

      ls_relation-klart    = iv_klart.
      ls_relation-node     = iv_node.
      ls_relation-ancestor = iv_ancestor.
      ls_relation-datuv    = iv_datuv.
      ls_relation-datub    = iv_datub.
    ls_relation-aennr    = iv_aennr.                        "end 2739754

    IF iv_upd_relev = abap_true.

      READ TABLE mt_clhier_idx_delete                     "begin 2739754
                 TRANSPORTING NO FIELDS
                 WITH KEY
                   node     = ls_relation-node
                   ancestor = ls_relation-ancestor
                   datuv    = ls_relation-datuv
                 BINARY SEARCH.

      IF sy-subrc EQ 0.
         DELETE mt_clhier_idx_delete INDEX sy-tabix.
      ENDIF.

*      DELETE mt_clhier_idx_delete
*        WHERE
*          node     = ls_relation-node AND
*          ancestor = ls_relation-ancestor AND
*          datuv    = ls_relation-datuv.                    "end 2739754

      IF sy-subrc = 0.
*        APPEND ls_relation TO mt_clhier_idx_update.      "begin 2739754
        READ TABLE mt_clhier_idx_update
                   TRANSPORTING NO FIELDS
                   WITH KEY
                     klart    = ls_relation-klart
                     node     = ls_relation-node
                     ancestor = ls_relation-ancestor
                     datuv    = ls_relation-datuv
                     datub    = ls_relation-datub
                     aennr    = ls_relation-aennr
                   BINARY SEARCH.
        IF sy-subrc NE 0.
          INSERT ls_relation INTO mt_clhier_idx_update INDEX sy-tabix.
        ENDIF.                                              "end 2739754
      ELSE.
        READ TABLE mt_clhier_idx_insert
          TRANSPORTING NO FIELDS
          WITH KEY
            node     = ls_relation-node
            ancestor = ls_relation-ancestor
            datuv    = ls_relation-datuv
          BINARY SEARCH.                                        "2739754

        IF sy-subrc <> 0.
*          APPEND ls_relation TO mt_clhier_idx_insert.
          INSERT ls_relation INTO mt_clhier_idx_insert INDEX sy-tabix.
        ENDIF.
      ENDIF.

*      READ TABLE mt_relevant_relations WITH KEY           "begin 2739754
*                                        node     = ls_relation-node
*                                        ancestor = ls_relation-ancestor
*                                        datuv    = ls_relation-datuv
*                                       TRANSPORTING NO FIELDS
*                                       BINARY SEARCH.
*      IF sy-subrc NE 0.
*        INSERT ls_relation INTO mt_relevant_relations INDEX sy-tabix.
*      ENDIF.
*      APPEND ls_relation TO mt_relevant_relations.         "end 2739754
    INSERT ls_relation INTO TABLE mt_relevant_relations.        "2790065

    ELSE.
      READ TABLE mt_clhier_idx_insert WITH KEY            "begin 2739754
                                        node     = ls_relation-node
                                        ancestor = ls_relation-ancestor
                                        datuv    = ls_relation-datuv
                                       TRANSPORTING NO FIELDS
                                       BINARY SEARCH.
      IF sy-subrc NE 0.
        INSERT ls_relation INTO mt_clhier_idx_insert INDEX sy-tabix.
      ENDIF.

*      APPEND INITIAL LINE TO mt_clhier_idx_insert ASSIGNING FIELD-SYMBOL(<ls_relation>).
*      <ls_relation>-klart    = iv_klart.
*      <ls_relation>-node     = iv_node.
*      <ls_relation>-ancestor = iv_ancestor.
*      <ls_relation>-datuv    = iv_datuv.
*      <ls_relation>-datub    = iv_datub.
*      <ls_relation>-aennr    = iv_aennr.                   "end 2739754
    ENDIF.
  ENDMETHOD.