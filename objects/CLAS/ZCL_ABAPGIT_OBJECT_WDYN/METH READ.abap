  METHOD read.

    DATA: lt_objects        TYPE wdy_md_transport_keys,
          ls_controller_key TYPE wdy_md_controller_key,
          ls_component_key  TYPE wdy_md_component_key,
          ls_view_key       TYPE wdy_md_view_key.

    FIELD-SYMBOLS: <ls_object>               LIKE LINE OF lt_objects,
                   <ls_meta>                 LIKE LINE OF rs_component-ctlr_metadata,
                   <ls_view>                 LIKE LINE OF rs_component-view_metadata,
                   <lt_ctrl_exceptions>      TYPE ANY TABLE,
                   <lt_ctrl_exception_texts> TYPE ANY TABLE.

    CLEAR mt_components.
    CLEAR mt_sources.

    lt_objects = get_limu_objects( ).

    LOOP AT lt_objects ASSIGNING <ls_object>.
      CASE <ls_object>-sub_type.
        WHEN wdyn_limu_component_controller.
          ls_controller_key = <ls_object>-sub_name.
          APPEND read_controller( ls_controller_key ) TO rs_component-ctlr_metadata.
        WHEN wdyn_limu_component_definition.
          ls_component_key = <ls_object>-sub_name.
          rs_component-comp_metadata = read_definition( ls_component_key ).
        WHEN wdyn_limu_component_view.
          ls_view_key = <ls_object>-sub_name.
          APPEND read_view( ls_view_key ) TO rs_component-view_metadata.
        WHEN OTHERS.
          ASSERT 0 = 1.
      ENDCASE.
    ENDLOOP.

    SORT rs_component-ctlr_metadata BY
      definition-component_name ASCENDING
      definition-controller_name ASCENDING.

    LOOP AT rs_component-ctlr_metadata ASSIGNING <ls_meta>.
      SORT <ls_meta>-descriptions.
      SORT <ls_meta>-controller_usages.
      SORT <ls_meta>-controller_components.
      SORT <ls_meta>-controller_component_texts.
      SORT <ls_meta>-controller_parameters.
      SORT <ls_meta>-controller_parameter_texts.
      SORT <ls_meta>-context_nodes.
      SORT <ls_meta>-context_attributes.
      SORT <ls_meta>-context_mappings.
      SORT <ls_meta>-fieldgroups.
*     Version 702 doesn't have these two attributes so we
*     use them dynamically for downward compatibility
      ASSIGN COMPONENT 'CONTROLLER_EXCEPTIONS' OF STRUCTURE <ls_meta> TO <lt_ctrl_exceptions>.
      IF sy-subrc = 0.
        SORT <lt_ctrl_exceptions>.
      ENDIF.
      ASSIGN COMPONENT 'CONTROLLER_EXCEPTION_TEXTS' OF STRUCTURE <ls_meta> TO <lt_ctrl_exception_texts>.
      IF sy-subrc = 0.
        SORT <lt_ctrl_exception_texts>.
      ENDIF.
    ENDLOOP.

    LOOP AT rs_component-view_metadata ASSIGNING <ls_view>.
      SORT <ls_view>-ui_elements.
    ENDLOOP.

    SORT mt_components BY
      component_name ASCENDING
      controller_name ASCENDING
      cmpname ASCENDING.

    SORT mt_sources BY
      component_name ASCENDING
      controller_name ASCENDING
      cmpname ASCENDING
      line_number ASCENDING.

  ENDMETHOD.