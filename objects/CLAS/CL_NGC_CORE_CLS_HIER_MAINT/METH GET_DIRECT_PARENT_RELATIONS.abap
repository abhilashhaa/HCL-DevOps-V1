  METHOD GET_DIRECT_PARENT_RELATIONS.
    LOOP AT mt_direct_relations ASSIGNING FIELD-SYMBOL(<ls_relation>).
      IF <ls_relation>-node = iv_node.
        APPEND <ls_relation> TO rt_direct_parent_relations.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.