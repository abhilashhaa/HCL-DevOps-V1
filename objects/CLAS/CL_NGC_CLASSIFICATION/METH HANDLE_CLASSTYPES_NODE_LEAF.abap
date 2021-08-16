  METHOD handle_classtypes_node_leaf.

*   This method uses table MT_CLASSTYPE_NODE_OR_LEAF to incorporate
*   node leaf information for the assigned classes.
*   In case we are handling node, the characteristics of the class
*   type should be handled as multi-value.
*   In case we ar handling a leaf, and we also have a parent object
*   (which is the node of this leaf), we need to handle the
*   characteristics for this class type as single-value.

    DATA:
      lo_clf_api_result             TYPE REF TO cl_ngc_clf_api_result,
      lv_was_change                 TYPE boole_d VALUE abap_false,
      lt_class_characteristic       TYPE ngct_class_characteristic,
      lt_class_characteristic_value TYPE ngct_class_charc_value,
      lt_characteristic_ref_all     TYPE ngct_characteristic_ref.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    IF mt_assigned_class IS INITIAL.
      eo_clf_api_result = lo_clf_api_result.
      RETURN.
    ENDIF.

    " process node class types - set characteristics of classes assigned to node-classtypes to multi-value
    LOOP AT mt_classtype_node_or_leaf ASSIGNING FIELD-SYMBOL(<ls_classtype_node_or_leaf>).

      LOOP AT mt_assigned_class ASSIGNING FIELD-SYMBOL(<ls_assigned_class>).
        IF <ls_assigned_class>-class_object->get_header( )-classtype <> <ls_classtype_node_or_leaf>-classtype.
          CONTINUE.
        ENDIF.

        CLEAR: lt_class_characteristic, lt_class_characteristic_value, lt_characteristic_ref_all.

        CASE <ls_classtype_node_or_leaf>-is_node.
          WHEN abap_true. " node - handle characteristics as multi-value

            <ls_assigned_class>-class_object->get_characteristics(
              IMPORTING
                et_characteristic          = DATA(lt_class_charc_obj)
                et_characteristic_org_area = DATA(lt_class_charc_org_ar)
            ).

            LOOP AT lt_class_charc_obj ASSIGNING FIELD-SYMBOL(<ls_class_charc_obj>).
              DATA(lt_characteristic_ref) = <ls_class_charc_obj>-characteristic_object->get_characteristic_ref( ).
              APPEND LINES OF lt_characteristic_ref TO lt_characteristic_ref_all.

              IF <ls_class_charc_obj>-characteristic_object->get_header( )-multiplevaluesareallowed = abap_true.
                CONTINUE. " it is already single value - no need to do anything
              ENDIF.
              lv_was_change = abap_true.
              APPEND INITIAL LINE TO lt_class_characteristic ASSIGNING FIELD-SYMBOL(<ls_class_characteristic>).
              <ls_class_characteristic>-classinternalid = <ls_assigned_class>-classinternalid.
              <ls_class_characteristic>-charcinternalid = <ls_class_charc_obj>-charcinternalid.
              <ls_class_characteristic>-key_date        = <ls_class_charc_obj>-key_date.
              READ TABLE lt_class_charc_org_ar ASSIGNING FIELD-SYMBOL(<ls_class_charc_org_ar>)
                WITH KEY charcinternalid = <ls_class_characteristic>-charcinternalid.
              IF sy-subrc = 0.
                <ls_class_characteristic>-clfnorganizationalarea = <ls_class_charc_org_ar>-clfnorganizationalarea.
              ENDIF.
              <ls_class_characteristic>-classtype = <ls_assigned_class>-class_object->get_header( )-classtype.
              MOVE-CORRESPONDING <ls_class_charc_obj>-characteristic_object->get_header( ) TO <ls_class_characteristic>.

              " here we override the characteristic master data with multiple values allowed enabled
              <ls_class_characteristic>-multiplevaluesareallowed = abap_true.
            ENDLOOP.

            IF lv_was_change = abap_true.
              <ls_assigned_class>-class_object = mo_ngc_api_factory->create_class_with_charcs(
                is_class_header                = <ls_assigned_class>-class_object->get_header( )
                it_class_characteristics       = lt_class_characteristic
                it_characteristic_ref          = lt_characteristic_ref_all
              ).
              lv_was_change = abap_false.
            ENDIF.

          WHEN abap_false. " leaf - handle characteristics as single value, and restric domain value set
            IF <ls_classtype_node_or_leaf>-parent_classification_key IS NOT INITIAL.

              <ls_assigned_class>-class_object->get_characteristics(
                IMPORTING
                  et_characteristic          = lt_class_charc_obj
                  et_characteristic_org_area = lt_class_charc_org_ar
              ).

              LOOP AT lt_class_charc_obj ASSIGNING <ls_class_charc_obj>.
                lt_characteristic_ref = <ls_class_charc_obj>-characteristic_object->get_characteristic_ref( ).
                APPEND LINES OF lt_characteristic_ref TO lt_characteristic_ref_all.

                APPEND INITIAL LINE TO lt_class_characteristic ASSIGNING <ls_class_characteristic>.
                <ls_class_characteristic>-classinternalid = <ls_assigned_class>-classinternalid.
                <ls_class_characteristic>-charcinternalid = <ls_class_charc_obj>-charcinternalid.
                <ls_class_characteristic>-key_date        = <ls_class_charc_obj>-key_date.
                READ TABLE lt_class_charc_org_ar ASSIGNING <ls_class_charc_org_ar>
                  WITH KEY charcinternalid = <ls_class_characteristic>-charcinternalid.
                IF sy-subrc = 0.
                  <ls_class_characteristic>-clfnorganizationalarea = <ls_class_charc_org_ar>-clfnorganizationalarea.
                ENDIF.
                <ls_class_characteristic>-classtype = <ls_assigned_class>-class_object->get_header( )-classtype.
                MOVE-CORRESPONDING <ls_class_charc_obj>-characteristic_object->get_header( ) TO <ls_class_characteristic>.

                " fill up domain values - restrict value set if it is necessary
                mo_ngc_api_factory->get_api( )->if_ngc_clf_api_read~read(
                  EXPORTING
                    it_classification_key    = VALUE #( ( <ls_classtype_node_or_leaf>-parent_classification_key ) )
                  IMPORTING
                    et_classification_object = DATA(lt_parent_classification_obj)
                    eo_clf_api_result        = DATA(lo_clf_api_result_tmp)
                ).
                lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

                READ TABLE lt_parent_classification_obj INDEX 1 ASSIGNING FIELD-SYMBOL(<ls_parent_classification_obj>).
                IF sy-subrc = 0.
                  <ls_parent_classification_obj>-classification->get_assigned_values(
                    EXPORTING
                      iv_classtype      = <ls_assigned_class>-class_object->get_header( )-classtype
                    IMPORTING
                      et_valuation_data = DATA(lt_parent_valuation_data)
                      eo_clf_api_result = lo_clf_api_result_tmp
                  ).
                  lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

                  IF lt_parent_valuation_data IS NOT INITIAL.
                    LOOP AT lt_parent_valuation_data ASSIGNING FIELD-SYMBOL(<ls_parent_valuation_data>).
                      APPEND INITIAL LINE TO lt_class_characteristic_value ASSIGNING FIELD-SYMBOL(<ls_class_characteristic_val>).
                      <ls_class_characteristic_val>-classinternalid = <ls_assigned_class>-classinternalid.
                      <ls_class_characteristic_val>-charcinternalid = <ls_class_charc_obj>-charcinternalid.
                      <ls_class_characteristic_val>-key_date        = <ls_class_charc_obj>-key_date.
                      MOVE-CORRESPONDING <ls_parent_valuation_data> TO <ls_class_characteristic_val>.
                    ENDLOOP.
                  ENDIF.
                ENDIF.

              ENDLOOP.

              <ls_assigned_class>-class_object = mo_ngc_api_factory->create_class_with_charcs(
                is_class_header                = <ls_assigned_class>-class_object->get_header( )
                it_class_characteristics       = lt_class_characteristic
                it_class_characteristic_values = lt_class_characteristic_value
                it_characteristic_ref          = lt_characteristic_ref_all
              ).
            ENDIF.

        ENDCASE.
      ENDLOOP.
    ENDLOOP.

    me->mo_clf_util_intersect->recalculate_all( ).

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.