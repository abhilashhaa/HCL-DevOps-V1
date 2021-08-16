  METHOD call_badi_node_leaf.

    DATA:
      lo_badi TYPE REF TO ngc_clf_node_leaf.

    CLEAR: es_parent_classification_key, et_child_classification_key.

    TRY.
        GET BADI lo_badi
          FILTERS
            technical_object = ms_classification_key-technical_object
            classtype        = iv_classtype.

        TEST-SEAM badi_get_node_leaf.
          CALL BADI lo_badi->get_node_leaf
            EXPORTING
              iv_classtype                 = iv_classtype
              is_classification_key        = ms_classification_key
              it_classification_ref_data   = mt_reference_data
            CHANGING
              cv_processing_node           = cv_processing_node
              cs_parent_classification_key = es_parent_classification_key
              ct_child_classification_key  = et_child_classification_key.
        END-TEST-SEAM.

      CATCH cx_badi ##no_handler.
    ENDTRY.

  ENDMETHOD.