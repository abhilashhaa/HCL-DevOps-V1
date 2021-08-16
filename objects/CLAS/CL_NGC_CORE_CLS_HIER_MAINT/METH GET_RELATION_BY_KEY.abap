  METHOD get_relation_by_key.
    READ TABLE mt_relevant_relations                           "2790065
      INTO rs_relation
      WITH TABLE KEY primary_key
        COMPONENTS
        node     = iv_node
        ancestor = iv_ancestor
        datuv    = iv_datuv.
  ENDMETHOD.