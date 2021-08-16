  METHOD DELETE_RELATION.
    DATA:
      ls_relation           TYPE ngc_clhier_idx,
      lt_relations_for_node TYPE ngct_clhier_idx,
      ls_relation_for_node  TYPE ngc_clhier_idx,
      lv_node               TYPE clint.

    me->precheck_dates(
      iv_datuv      = iv_datuv
      iv_datub      = iv_datub
      iv_table_name = gc_table_kssk ).

    ls_relation = me->get_valid_relation(
      EXPORTING
        iv_node     = iv_node
        iv_ancestor = iv_ancestor
        iv_datuv    = iv_datuv
        iv_datub    = iv_datub ).

    " Get ancestors, descendants and relevant relations.
    DATA(lt_ancestor_relations) = me->get_ancestor_relations(
      iv_node  = ls_relation-ancestor
      iv_datuv = ls_relation-datuv
      iv_datub = ls_relation-datub ).
    APPEND ls_relation TO lt_ancestor_relations.

    DATA(lt_descendant_relations) = me->get_descendant_relations(
      iv_node  = ls_relation-node
      iv_datuv = ls_relation-datuv
      iv_datub = ls_relation-datub ).
    APPEND ls_relation TO lt_descendant_relations.

    me->get_relations(
      EXPORTING
        it_ancestors     = lt_ancestor_relations
        it_descendants   = lt_descendant_relations
        iv_datuv         = iv_datuv
        iv_datub         = iv_datub
        iv_aennr         = iv_aennr
      IMPORTING
        et_updatable     = DATA(lt_relations) ).

* moved to here, as mt_direct_relations seems only to be used in deletion
    IF mt_relevant_relations[] IS NOT INITIAL.            "begin 2699010
      DATA: mt_relevant_relations_unsorted                "begin 2790065
                                 TYPE TABLE OF NGC_CLHIER_IDX.
      mt_relevant_relations_unsorted[] = mt_relevant_relations[].
      mt_direct_relations  = mo_db_access->get_direct_relations( mt_relevant_relations_unsorted ).
      CLEAR: mt_relevant_relations_unsorted[].              "end 2790065
    ENDIF.                                                  "end 2699010

    " Valid pathes are calculated by node so grouping is required.
    LOOP AT lt_relations INTO ls_relation
      GROUP BY ( node = ls_relation-node )
      REFERENCE INTO DATA(ls_relation_group).

      CLEAR lt_relations_for_node.
      LOOP AT GROUP ls_relation_group INTO ls_relation_for_node.
        APPEND ls_relation_for_node TO lt_relations_for_node.
      ENDLOOP.

      me->update_existing_relations(
        iv_root_node          = ls_relation_group->node
        it_relations_for_node = lt_relations_for_node ).
    ENDLOOP.

*    SORT lt_relations BY node.
*
*    READ TABLE lt_relations
*      TRANSPORTING NO FIELDS
*      INDEX 1.
*
*    IF sy-subrc = 0.
*      lv_node = lt_relations[ 1 ]-node.
*
*      LOOP AT lt_relations INTO ls_relation.
*        IF lv_node = ls_relation-node.
*          APPEND ls_relation TO lt_relations_for_node.
*        ELSE.
*          update_existing_relations(
*            iv_root_node          = lv_node
*            it_relations_for_node = lt_relations_for_node ).
*
*          CLEAR lt_relations_for_node.
*          APPEND ls_relation TO lt_relations_for_node.
*        ENDIF.
*
*        lv_node   = ls_relation-node.
*      ENDLOOP.
*
*      update_existing_relations(
*        iv_root_node          = lv_node
*        it_relations_for_node = lt_relations_for_node ).
*    ENDIF.
  ENDMETHOD.