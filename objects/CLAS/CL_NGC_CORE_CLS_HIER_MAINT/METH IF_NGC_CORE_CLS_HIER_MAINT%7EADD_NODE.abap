  METHOD if_ngc_core_cls_hier_maint~add_node.
    me->precheck_dates(
      iv_datuv      = iv_datuv
      iv_datub      = iv_datub
      iv_table_name = gc_table_klah ).

    me->insert_record(
      iv_klart     = iv_klart
      iv_node      = iv_node
      iv_ancestor  = iv_node
      iv_datuv     = iv_datuv
      iv_datub     = iv_datub
      iv_aennr     = ''
      iv_upd_relev = iv_upd_relev ).
  ENDMETHOD.