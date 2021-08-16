  METHOD zif_abapgit_object~deserialize.

    DATA: ls_component   TYPE wdy_component_metadata,
          ls_description TYPE wdy_ext_ctx_map.

    FIELD-SYMBOLS: <ls_view>       LIKE LINE OF ls_component-view_metadata,
                   <ls_controller> LIKE LINE OF ls_component-ctlr_metadata.

    io_xml->read( EXPORTING iv_name = 'COMPONENT'
                  CHANGING cg_data = ls_component ).
    io_xml->read( EXPORTING iv_name  = 'COMPONENTS'
                  CHANGING cg_data = mt_components ).
    io_xml->read( EXPORTING iv_name  = 'SOURCES'
                  CHANGING cg_data = mt_sources ).

    ls_component-comp_metadata-definition-author = sy-uname.
    ls_component-comp_metadata-definition-createdon = sy-datum.
    recover_definition( is_definition = ls_component-comp_metadata
                        iv_package    = iv_package ).

    LOOP AT ls_component-ctlr_metadata ASSIGNING <ls_controller>.
      <ls_controller>-definition-author = sy-uname.
      <ls_controller>-definition-createdon = sy-datum.
      recover_controller( <ls_controller> ).
    ENDLOOP.
    LOOP AT ls_component-view_metadata ASSIGNING <ls_view>.
      <ls_view>-definition-author = sy-uname.
      <ls_view>-definition-createdon = sy-datum.
      recover_view( <ls_view> ).
    ENDLOOP.

    READ TABLE ls_component-comp_metadata-descriptions INTO ls_description INDEX 1.
    IF sy-subrc = 0.
      zcl_abapgit_sotr_handler=>create_sotr(
        iv_package = iv_package
        io_xml     = io_xml ).
    ENDIF.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.