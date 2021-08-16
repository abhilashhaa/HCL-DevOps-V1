  METHOD if_ex_cacl_classficatn_update~after_update.

    IF mt_kssk_ins IS NOT INITIAL.
      mo_cls_hier_maint->update_relations(
        it_relations = mt_kssk_ins
        iv_action    = 'I' ).
    ENDIF.

    IF mt_kssk_del IS NOT INITIAL.
      mo_cls_hier_maint->update_relations(
        it_relations = mt_kssk_del
        iv_action    = 'D' ).
    ENDIF.

    IF mt_kssk_upd IS NOT INITIAL.
      mo_cls_hier_maint->update_relations(
        it_relations = mt_kssk_upd
        iv_action    = 'U'
        iv_new_date  = mv_new_date ).
    ENDIF.

    IF mt_kssk_ins IS NOT INITIAL OR
       mt_kssk_del IS NOT INITIAL OR
       mt_kssk_upd IS NOT INITIAL.
      mo_cls_hier_maint->update( ).
    ENDIF.

    CLEAR mt_kssk_ins.
    CLEAR mt_kssk_del.
    CLEAR mt_kssk_upd.
    CLEAR mv_new_date.

  ENDMETHOD.