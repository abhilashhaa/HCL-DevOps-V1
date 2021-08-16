  METHOD setup_classtypes_node_leaf.

*   This method sets up table MT_CLASSTYPE_NODE_OR_LEAF, which stores
*   the information whether a class type should be handled as node
*   in the current classification.
*   This depends on the classification customizing and on the
*   object-specific and class-type specific implementation of BAdI
*   NGC_CLF_NODE_LEAF.
*   The basis of this implementation was include LCTMSF2T, but it is
*   completely rewritten.

    CLEAR: mt_classtype_node_or_leaf.

    DATA:
      lv_is_node                  TYPE boole_d VALUE abap_false,
      lv_clfnobjecthierarchylevel TYPE clsortpos.

    " setup of class types for node leaf concept
    DATA(lt_classtypes_all) = mo_clf_persistency->read_classtypes( ).
    DELETE lt_classtypes_all WHERE clfnobjecthierarchylevel = space.
    SORT lt_classtypes_all BY classtype clfnobjecttable ASCENDING.

    LOOP AT lt_classtypes_all ASSIGNING FIELD-SYMBOL(<ls_classtype>)
      WHERE clfnobjecttable = ms_classification_key-technical_object.

      READ TABLE mt_classtype_node_or_leaf TRANSPORTING NO FIELDS
        WITH KEY classtype = <ls_classtype>-classtype.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      CLEAR: lv_is_node, lv_clfnobjecthierarchylevel.

      lv_clfnobjecthierarchylevel = <ls_classtype>-clfnobjecthierarchylevel.

      IF lv_clfnobjecthierarchylevel <> space.
        LOOP AT lt_classtypes_all TRANSPORTING NO FIELDS
          WHERE
            clfnobjecthierarchylevel > lv_clfnobjecthierarchylevel AND
            classtype                = <ls_classtype>-classtype.
          lv_is_node = abap_true.
          EXIT.
        ENDLOOP.
        call_badi_node_leaf(
          EXPORTING
            iv_classtype                 = <ls_classtype>-classtype
          IMPORTING
            es_parent_classification_key = DATA(ls_parent_classification_key)
            et_child_classification_key  = DATA(lt_child_classification_key)
          CHANGING
            cv_processing_node           = lv_is_node ).
      ENDIF.

      APPEND VALUE #(
        classtype                 = <ls_classtype>-classtype
        is_node                   = lv_is_node
        parent_classification_key = ls_parent_classification_key
        child_classification_key  = lt_child_classification_key
      ) TO mt_classtype_node_or_leaf.

    ENDLOOP.

    " handle node leaf information for assigned classes
    handle_classtypes_node_leaf( ).

  ENDMETHOD.