  METHOD get_relations.
    DATA:
      ls_relation           TYPE ngc_clhier_idx,
      lt_existing_relations TYPE ngct_clhier_idx,
      lv_datuv              TYPE datuv,
      lv_datub              TYPE datub,
      lv_overlap            TYPE abap_bool,
      lv_exists             TYPE abap_bool VALUE abap_false.

    CLEAR: et_insertable, et_updatable, et_removable.

    LOOP AT it_descendants ASSIGNING FIELD-SYMBOL(<ls_descendant>).
      LOOP AT it_ancestors ASSIGNING FIELD-SYMBOL(<ls_ancestor>).
        lv_overlap = cl_ngc_core_cls_util=>check_overlap(
          iv_valid_from1 = <ls_descendant>-datuv
          iv_valid_to1   = <ls_descendant>-datub
          iv_valid_from2 = <ls_ancestor>-datuv
          iv_valid_to2   = <ls_ancestor>-datub ).

        IF lv_overlap = abap_true.
          ls_relation-ancestor = <ls_ancestor>-ancestor.
          ls_relation-node     = <ls_descendant>-node.
          ls_relation-klart    = <ls_ancestor>-klart.
          ls_relation-datuv    = cl_ngc_core_cls_util=>maximum_date(
            iv_date1 = <ls_descendant>-datuv
            iv_date2 = <ls_ancestor>-datuv
            iv_date3 = iv_datuv ).
          ls_relation-datub    = cl_ngc_core_cls_util=>minimum_date(
            iv_date1 = <ls_descendant>-datub
            iv_date2 = <ls_ancestor>-datub
            iv_date3 = iv_datub ).

          IF ls_relation-datuv = <ls_descendant>-datuv.
            ls_relation-aennr = <ls_descendant>-aennr.
          ELSEIF ls_relation-datuv = <ls_ancestor>-datuv.
            ls_relation-aennr = <ls_ancestor>-aennr.
          ELSE.
            ls_relation-aennr = iv_aennr.
          ENDIF.

          IF ls_relation-datuv <> '00010101' AND ls_relation-datuv <> '00000000'.
            lv_datuv = ls_relation-datuv - 1.
          ELSE.
            lv_datuv = ls_relation-datuv.
          ENDIF.
          IF ls_relation-datub <> '99991231'.
            lv_datub = ls_relation-datub + 1.
          ELSE.
            lv_datub = ls_relation-datub.
          ENDIF.

          lt_existing_relations = me->get_valid_relations(
              iv_node     = ls_relation-node
              iv_ancestor = ls_relation-ancestor
              iv_datuv    = lv_datuv
              iv_datub    = lv_datub ).

          LOOP AT lt_existing_relations ASSIGNING FIELD-SYMBOL(<ls_existing_relation>).
            IF <ls_existing_relation>-datuv <= ls_relation-datuv.
              ls_relation-datuv = <ls_existing_relation>-datuv.
              ls_relation-aennr = <ls_existing_relation>-aennr.

              lv_exists = abap_true.
            ELSEIF <ls_existing_relation>-datuv > ls_relation-datuv.
              APPEND <ls_existing_relation> TO et_removable.
            ENDIF.

            IF <ls_existing_relation>-datub > ls_relation-datub.
              ls_relation-datub = <ls_existing_relation>-datub.
            ENDIF.
          ENDLOOP.

          IF lv_exists = abap_true.
            APPEND ls_relation TO et_updatable.
          ELSE.
            APPEND ls_relation TO et_insertable.
          ENDIF.

          CLEAR ls_relation.
          lv_exists = abap_false.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.