  METHOD read_view.

    DATA: lt_definition TYPE TABLE OF wdy_view_vrs,
          lt_psmodilog  TYPE TABLE OF smodilog,
          lt_psmodisrc  TYPE TABLE OF smodisrc.

    FIELD-SYMBOLS: <ls_definition> LIKE LINE OF lt_definition.


    CALL FUNCTION 'WDYV_GET_OBJECT'
      EXPORTING
        view_key               = is_key
        get_all_translations   = abap_false
      TABLES
        definition             = lt_definition
        descriptions           = rs_view-descriptions
        view_containers        = rs_view-view_containers
        view_container_texts   = rs_view-view_container_texts
        iobound_plugs          = rs_view-iobound_plugs
        iobound_plug_texts     = rs_view-iobound_plug_texts
        plug_parameters        = rs_view-plug_parameters
        plug_parameter_texts   = rs_view-plug_parameter_texts
        ui_elements            = rs_view-ui_elements
        ui_context_bindings    = rs_view-ui_context_bindings
        ui_event_bindings      = rs_view-ui_event_bindings
        ui_ddic_bindings       = rs_view-ui_ddic_bindings
        ui_properties          = rs_view-ui_properties
        navigation_links       = rs_view-navigation_links
        navigation_target_refs = rs_view-navigation_target_refs
        vsh_nodes              = rs_view-vsh_nodes
        vsh_placeholders       = rs_view-vsh_placeholders
        viewset_properties     = rs_view-viewset_properties
        psmodilog              = lt_psmodilog
        psmodisrc              = lt_psmodisrc
      EXCEPTIONS
        not_existing           = 1
        OTHERS                 = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from WDYV_GET_OBJECT' ).
    ENDIF.

    READ TABLE lt_definition INDEX 1 ASSIGNING <ls_definition>.
    ASSERT sy-subrc = 0.
    MOVE-CORRESPONDING <ls_definition> TO rs_view-definition.

    CLEAR: rs_view-definition-author,
           rs_view-definition-createdon,
           rs_view-definition-changedby,
           rs_view-definition-changedon.

  ENDMETHOD.