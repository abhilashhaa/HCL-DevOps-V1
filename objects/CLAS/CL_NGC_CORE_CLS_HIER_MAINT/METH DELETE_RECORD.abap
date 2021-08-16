  METHOD delete_record.
    DATA ls_relation TYPE ngc_clhier_idx.

    ls_relation-node     = iv_node.
    ls_relation-ancestor = iv_ancestor.
    ls_relation-datuv    = iv_datuv.

    READ TABLE mt_clhier_idx_insert                       "begin 2739754
               TRANSPORTING NO FIELDS
               WITH KEY
                 node     = ls_relation-node
                 ancestor = ls_relation-ancestor
                 datuv    = ls_relation-datuv
          BINARY SEARCH.

    IF sy-subrc EQ 0.
       DELETE mt_clhier_idx_insert INDEX sy-tabix.
    ENDIF.

*    DELETE mt_clhier_idx_insert
*      WHERE
*        node     = ls_relation-node AND
*        ancestor = ls_relation-ancestor AND
*        datuv    = ls_relation-datuv.                      "end 2739754

    IF sy-subrc <> 0.
      READ TABLE mt_clhier_idx_delete
      TRANSPORTING NO FIELDS
      WITH KEY
        node     = ls_relation-node
        ancestor = ls_relation-ancestor
        datuv    = ls_relation-datuv
        BINARY SEARCH.                                          "2739754

      IF sy-subrc <> 0.
        INSERT ls_relation INTO  mt_clhier_idx_delete INDEX sy-tabix.  "2739754
*        APPEND ls_relation TO mt_clhier_idx_delete.                   "2739754
      ENDIF.
    ENDIF.

    DELETE mt_relevant_relations                          "begin 2790065
      WHERE
        node     = ls_relation-node AND
        ancestor = ls_relation-ancestor AND
        datuv    = ls_relation-datuv.                       "end 2790065

  ENDMETHOD.