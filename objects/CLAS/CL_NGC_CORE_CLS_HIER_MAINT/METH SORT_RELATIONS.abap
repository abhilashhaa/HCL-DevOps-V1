  METHOD sort_relations.
*new with note 2739754, not used after note 2790065
*    SORT mt_relevant_relations BY node ancestor datuv.
*    DELETE ADJACENT DUPLICATES FROM mt_relevant_relations.
  ENDMETHOD.