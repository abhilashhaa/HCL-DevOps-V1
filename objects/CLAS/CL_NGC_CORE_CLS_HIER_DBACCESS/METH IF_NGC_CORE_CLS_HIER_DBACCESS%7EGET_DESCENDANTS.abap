  METHOD if_ngc_core_cls_hier_dbaccess~get_descendants.
    IF it_relations IS NOT INITIAL.
      DATA(lt_relations) = convert_idx_from_kssk( it_relations = it_relations ).

      SELECT * FROM ngc_clhier_idx
        INTO TABLE rt_descendants
        FOR ALL ENTRIES IN lt_relations
        WHERE
          ancestor =  lt_relations-node AND
          node     <> ngc_clhier_idx~ancestor AND
          datub    >= lt_relations-datuv AND
          datuv    <= lt_relations-datub.
    ENDIF.
  ENDMETHOD.