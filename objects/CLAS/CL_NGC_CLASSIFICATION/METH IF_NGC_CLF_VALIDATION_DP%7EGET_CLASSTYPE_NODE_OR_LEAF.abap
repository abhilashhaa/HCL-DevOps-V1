  METHOD if_ngc_clf_validation_dp~get_classtype_node_or_leaf.

    CLEAR: ev_is_node, es_parent_classification_key, et_child_classification_key.

    READ TABLE mt_classtype_node_or_leaf ASSIGNING FIELD-SYMBOL(<ls_classtype_node_or_leaf>)
      WITH KEY classtype = iv_classtype.
    IF sy-subrc = 0.
      ev_is_node                   = <ls_classtype_node_or_leaf>-is_node.
      es_parent_classification_key = <ls_classtype_node_or_leaf>-parent_classification_key.
      et_child_classification_key  = <ls_classtype_node_or_leaf>-child_classification_key.
    ENDIF.

  ENDMETHOD.