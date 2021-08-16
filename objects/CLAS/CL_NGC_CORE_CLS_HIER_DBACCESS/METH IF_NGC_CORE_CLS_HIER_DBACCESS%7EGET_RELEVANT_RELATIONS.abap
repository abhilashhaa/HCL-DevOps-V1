  METHOD if_ngc_core_cls_hier_dbaccess~get_relevant_relations.
    IF it_descendants IS NOT INITIAL.
      SELECT * FROM ngc_clhier_idx
        INTO TABLE rt_relations
        FOR ALL ENTRIES IN it_descendants
        WHERE
          ( node     = it_descendants-node OR
            ancestor = it_descendants-ancestor ) AND
          node <> ngc_clhier_idx~ancestor.
    ENDIF.

    DATA(lt_relations) = convert_idx_from_kssk( it_relations = it_relations ).

    IF lt_relations IS NOT INITIAL.
      SELECT * FROM ngc_clhier_idx
        APPENDING TABLE rt_relations
        FOR ALL ENTRIES IN lt_relations
        WHERE
          ( node     = lt_relations-node OR
            ancestor = lt_relations-ancestor ) AND
          node <> ngc_clhier_idx~ancestor.
    ENDIF.

    APPEND LINES OF it_descendants TO rt_relations.
    APPEND LINES OF it_ancestors TO rt_relations.

    SORT rt_relations BY node ancestor datuv.
    DELETE ADJACENT DUPLICATES FROM rt_relations COMPARING node ancestor datuv.
  ENDMETHOD.