  METHOD add_relation.
    DATA ls_relation TYPE ngc_clhier_idx.

    FIELD-SYMBOLS:
      <ls_relation> LIKE ls_relation.

    me->precheck_dates(
      iv_datuv      = iv_datuv
      iv_datub      = iv_datub
      iv_table_name = gc_table_kssk ).

    ls_relation-node     = iv_node.
    ls_relation-ancestor = iv_ancestor.
    ls_relation-datuv    = iv_datuv.
    ls_relation-datub    = iv_datub.
    ls_relation-klart    = iv_klart.
    ls_relation-aennr    = iv_aennr.

    " Get ancestors, descendants and relevant relations.
    DATA(lt_ancestor_relations) = me->get_ancestor_relations(
      iv_node  = iv_ancestor
      iv_datuv = iv_datuv
      iv_datub = iv_datub ).
    APPEND ls_relation TO lt_ancestor_relations.

    DATA(lt_descendant_relations) = me->get_descendant_relations(
      iv_node  = iv_node
      iv_datuv = iv_datuv
      iv_datub = iv_datub ).
    APPEND ls_relation TO lt_descendant_relations.

    me->get_relations(
      EXPORTING
        it_ancestors     = lt_ancestor_relations
        it_descendants   = lt_descendant_relations
        iv_datuv         = iv_datuv
        iv_datub         = iv_datub
        iv_aennr         = iv_aennr
      IMPORTING
        et_insertable    = DATA(lt_insertable_relations)
        et_updatable     = DATA(lt_updatable_relations)
        et_removable     = DATA(lt_removable_relations) ).

    " Insert, update and delete result relations.
    LOOP AT lt_insertable_relations ASSIGNING <ls_relation>.
      me->insert_record(
        iv_node     = <ls_relation>-node
        iv_ancestor = <ls_relation>-ancestor
        iv_datuv    = <ls_relation>-datuv
        iv_datub    = <ls_relation>-datub
        iv_klart    = <ls_relation>-klart
        iv_aennr    = <ls_relation>-aennr ).
    ENDLOOP.

    LOOP AT lt_updatable_relations ASSIGNING <ls_relation>.
      me->update_record(
        iv_node     = <ls_relation>-node
        iv_ancestor = <ls_relation>-ancestor
        iv_datuv    = <ls_relation>-datuv
        iv_datub    = <ls_relation>-datub
        iv_klart    = <ls_relation>-klart
        iv_aennr    = <ls_relation>-aennr ).
    ENDLOOP.

    LOOP AT lt_removable_relations ASSIGNING <ls_relation>.
      me->delete_record(
          iv_node     = <ls_relation>-node
          iv_ancestor = <ls_relation>-ancestor
          iv_datuv    = <ls_relation>-datuv ).
    ENDLOOP.
  ENDMETHOD.