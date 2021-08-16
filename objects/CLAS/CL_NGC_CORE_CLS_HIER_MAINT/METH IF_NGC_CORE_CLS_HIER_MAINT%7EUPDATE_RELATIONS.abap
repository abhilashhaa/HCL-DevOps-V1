  METHOD if_ngc_core_cls_hier_maint~update_relations.
    DATA:
      lt_relations TYPE tt_kssk,
      lv_node      TYPE clint.

    FIELD-SYMBOLS:
      <ls_relation> LIKE LINE OF lt_relations.

    " Delete object classifications from relations.
    lt_relations = it_relations.
    DELETE lt_relations
      WHERE
        mafid <> 'K'.

    DATA(lt_ancestor_relations)   = mo_db_access->get_ancestors( lt_relations ).
    DATA(lt_descendant_relations) = mo_db_access->get_descendants( lt_relations ).

    mt_relevant_relations = mo_db_access->get_relevant_relations(
      it_descendants = lt_descendant_relations
      it_ancestors   = lt_ancestor_relations
      it_relations   = lt_relations ).

* moved to delete_relation with note   2699010
*    mt_direct_relations   = mo_db_access->get_direct_relations( mt_relevant_relations ).
*    sort_relations( ).                                          "2739754 2790065

    CASE iv_action.
      WHEN 'I'.
        LOOP AT lt_relations ASSIGNING <ls_relation>.
          lv_node = <ls_relation>-objek.

          IF <ls_relation>-lkenz = ' '.
            add_relation(
              iv_node     = lv_node
              iv_ancestor = <ls_relation>-clint
              iv_datuv    = <ls_relation>-datuv
              iv_datub    = <ls_relation>-datub
              iv_klart    = <ls_relation>-klart
              iv_aennr    = <ls_relation>-aennr ).
          ELSE.
            delete_relation(
              iv_node     = lv_node
              iv_ancestor = <ls_relation>-clint
              iv_datuv    = <ls_relation>-datuv
              iv_datub    = <ls_relation>-datub
              iv_klart    = <ls_relation>-klart
              iv_aennr    = <ls_relation>-aennr ).
          ENDIF.
        ENDLOOP.
      WHEN 'D'.
        LOOP AT lt_relations ASSIGNING <ls_relation>.
          lv_node = <ls_relation>-objek.

          delete_relation(
            iv_node     = lv_node
            iv_ancestor = <ls_relation>-clint
            iv_datuv    = <ls_relation>-datuv
            iv_datub    = <ls_relation>-datub
            iv_klart    = <ls_relation>-klart
            iv_aennr    = <ls_relation>-aennr ).
        ENDLOOP.
      WHEN 'U'.
        LOOP AT lt_relations ASSIGNING <ls_relation>.
          lv_node = <ls_relation>-objek.

          update_relation(
            iv_node     = lv_node
            iv_ancestor = <ls_relation>-clint
            iv_datuv    = <ls_relation>-datuv
            iv_datub    = <ls_relation>-datub
            iv_klart    = <ls_relation>-klart
            iv_aennr    = <ls_relation>-aennr
            iv_delete   = <ls_relation>-lkenz
            iv_new_date = iv_new_date ).
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.