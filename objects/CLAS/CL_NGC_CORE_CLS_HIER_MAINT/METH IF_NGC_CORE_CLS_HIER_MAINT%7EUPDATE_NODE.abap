  METHOD if_ngc_core_cls_hier_maint~update_node.
    SELECT SINGLE * FROM ngc_clhier_idx
      INTO @DATA(ls_class)
      WHERE
        node     = @iv_node AND
        ancestor = @iv_node.

    IF sy-subrc = 0.
      IF ls_class-datuv = iv_datuv.
        me->update_record(
          iv_node     = iv_node
          iv_ancestor = iv_node
          iv_datuv    = iv_datuv
          iv_datub    = iv_datub
          iv_klart    = ls_class-klart
          iv_aennr    = ls_class-aennr ).
      ELSE.
        me->delete_record(
            iv_node     = ls_class-node
            iv_ancestor = ls_class-ancestor
            iv_datuv    = ls_class-datuv ).

        me->insert_record(
          iv_node     = iv_node
          iv_ancestor = iv_node
          iv_datuv    = iv_datuv
          iv_datub    = iv_datub
          iv_klart    = ls_class-klart
          iv_aennr    = ls_class-aennr ).
      ENDIF.
    ELSE.
      me->insert_record(
        iv_node     = iv_node
        iv_ancestor = iv_node
        iv_datuv    = iv_datuv
        iv_datub    = iv_datub
        iv_klart    = ''
        iv_aennr    = '' ).
    ENDIF.
  ENDMETHOD.