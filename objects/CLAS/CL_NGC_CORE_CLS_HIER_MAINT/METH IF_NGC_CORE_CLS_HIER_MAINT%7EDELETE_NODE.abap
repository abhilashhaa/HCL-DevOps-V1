  METHOD if_ngc_core_cls_hier_maint~delete_node.
    me->delete_record(
      iv_node     = iv_node
      iv_ancestor = iv_node
      iv_datuv    = iv_datuv ).
  ENDMETHOD.