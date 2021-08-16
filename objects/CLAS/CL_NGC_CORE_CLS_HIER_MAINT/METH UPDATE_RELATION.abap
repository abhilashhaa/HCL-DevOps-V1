  METHOD update_relation.
    DATA: lt_items TYPE TABLE OF ngc_clhier_idx,
          ls_item  TYPE ngc_clhier_idx.

    IF iv_new_date IS INITIAL.
      " Delete or an insert of an alredy existing item.
      IF iv_delete = 'X'.
        me->delete_relation(
          iv_ancestor = iv_ancestor
          iv_node     = iv_node
          iv_datuv    = iv_datuv
          iv_datub    = iv_datub
          iv_klart    = iv_klart
          iv_aennr    = iv_aennr ).
      ELSE.
        me->add_relation(
          iv_ancestor = iv_ancestor
          iv_node     = iv_node
          iv_datuv    = iv_datuv
          iv_datub    = iv_datub
          iv_klart    = iv_klart
          iv_aennr    = iv_aennr ).
      ENDIF.
    ELSE.
      " Handle dateshift.
      DATA(ls_relation) = get_relation_by_key(
        iv_node     = iv_node
        iv_ancestor = iv_ancestor
        iv_datuv    = iv_datuv ).

      IF ls_relation IS INITIAL.
        " Could not find record which should be deleted.
*        RAISE EXCEPTION TYPE cx_ngc_core_cls_hier_maint.
        RETURN.
      ENDIF.

      DATA(lt_ancestor) = me->get_ancestor_relations(
        iv_node  = ls_relation-ancestor
        iv_datuv = ls_relation-datuv
        iv_datub = ls_relation-datub ).
      APPEND ls_relation TO lt_ancestor.

      DATA(lt_descendant) = me->get_descendant_relations(
        iv_node  = iv_node
        iv_datuv = ls_relation-datuv
        iv_datub = ls_relation-datub ).
      APPEND ls_relation TO lt_descendant.

      LOOP AT lt_descendant ASSIGNING FIELD-SYMBOL(<ls_descendant>).
        LOOP AT lt_ancestor ASSIGNING FIELD-SYMBOL(<ls_ancestor>).
          ls_item = me->get_relation_by_key(
            iv_node     = <ls_descendant>-node
            iv_ancestor = <ls_ancestor>-ancestor
            iv_datuv    = iv_datuv ).

          APPEND ls_item TO lt_items.
        ENDLOOP.
      ENDLOOP.

      LOOP AT lt_items INTO ls_item.
        IF ls_item-datuv = iv_datuv.
          me->delete_record(
              iv_node     = ls_item-node
              iv_ancestor = ls_item-ancestor
              iv_datuv    = ls_item-datuv ).

          me->insert_record(
              iv_node     = ls_item-node
              iv_ancestor = ls_item-ancestor
              iv_datuv    = iv_new_date
              iv_datub    = ls_item-datub
              iv_klart    = ls_item-klart
              iv_aennr    = ls_item-aennr ).
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.