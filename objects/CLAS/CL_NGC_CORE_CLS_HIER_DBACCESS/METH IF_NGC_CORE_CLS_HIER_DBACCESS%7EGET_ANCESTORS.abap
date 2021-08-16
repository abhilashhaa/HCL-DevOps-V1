  METHOD if_ngc_core_cls_hier_dbaccess~get_ancestors.
    IF it_relations IS NOT INITIAL.
      DATA(lt_relations) = convert_idx_from_kssk( it_relations = it_relations ).

      SELECT * FROM ngc_clhier_idx
        INTO TABLE rt_ancestors
        FOR ALL ENTRIES IN lt_relations
        WHERE
          node  =  lt_relations-ancestor AND
          node  <> ngc_clhier_idx~ancestor AND
          datub >= lt_relations-datuv AND
          datuv <= lt_relations-datub.
    ENDIF.
  ENDMETHOD.