  METHOD delta_controller.

    DATA: li_controller TYPE REF TO if_wdy_md_controller,
          lv_found      TYPE abap_bool,
          ls_key        TYPE wdy_md_controller_key,
          ls_obj_new    TYPE svrs2_versionable_object,
          ls_obj_old    TYPE svrs2_versionable_object.

    FIELD-SYMBOLS: <ls_component>            LIKE LINE OF mt_components,
                   <ls_source>               LIKE LINE OF mt_sources,
                   <lt_ctrl_exceptions>      TYPE ANY TABLE,
                   <lt_ctrl_exception_texts> TYPE ANY TABLE,
                   <lt_excp>                 TYPE ANY TABLE,
                   <lt_excpt>                TYPE ANY TABLE.


    ls_key-component_name = is_controller-definition-component_name.
    ls_key-controller_name = is_controller-definition-controller_name.

    lv_found = cl_wdy_md_controller=>check_existency(
          component_name  = ls_key-component_name
          controller_name = ls_key-controller_name ).
    IF lv_found = abap_false.
      TRY.
          li_controller ?= cl_wdy_md_controller=>create_complete(
                component_name  = ls_key-component_name
                controller_name = ls_key-controller_name
                controller_type = is_controller-definition-controller_type ).
          li_controller->save_to_database( ).
          li_controller->unlock( ).
        CATCH cx_wdy_md_exception.
          zcx_abapgit_exception=>raise( 'error creating dummy controller' ).
      ENDTRY.
    ENDIF.

    ls_obj_new-objtype = wdyn_limu_component_controller.
    ls_obj_new-objname = ls_key.

    ls_obj_old-objtype = wdyn_limu_component_controller.
    ls_obj_old-objname = ls_key.

    APPEND is_controller-definition TO ls_obj_old-wdyc-defin.

    LOOP AT mt_components ASSIGNING <ls_component>
        WHERE component_name = ls_key-component_name
        AND controller_name = ls_key-controller_name.
      APPEND <ls_component> TO ls_obj_old-wdyc-ccomp.
    ENDLOOP.
    LOOP AT mt_sources ASSIGNING <ls_source>
        WHERE component_name = ls_key-component_name
        AND controller_name = ls_key-controller_name.
      APPEND <ls_source> TO ls_obj_old-wdyc-ccoms.
    ENDLOOP.

    ls_obj_old-wdyc-descr = is_controller-descriptions.
    ls_obj_old-wdyc-cusag = is_controller-controller_usages.
    ls_obj_old-wdyc-ccomt = is_controller-controller_component_texts.
    ls_obj_old-wdyc-cpara = is_controller-controller_parameters.
    ls_obj_old-wdyc-cpart = is_controller-controller_parameter_texts.
    ls_obj_old-wdyc-cnode = is_controller-context_nodes.
    ls_obj_old-wdyc-cattr = is_controller-context_attributes.
    ls_obj_old-wdyc-cmapp = is_controller-context_mappings.
*   Version 702 doesn't have these two attributes so we
*   use them dynamically for downward compatibility
    ASSIGN COMPONENT 'CONTROLLER_EXCEPTIONS' OF STRUCTURE is_controller
      TO <lt_ctrl_exceptions>.
    IF sy-subrc = 0.
      ASSIGN COMPONENT 'EXCP' OF STRUCTURE ls_obj_old-wdyc TO <lt_excp>.
      IF sy-subrc = 0.
        <lt_excp> = <lt_ctrl_exceptions>.
      ENDIF.
    ENDIF.
    ASSIGN COMPONENT 'CONTROLLER_EXCEPTIONS_TEXTS' OF STRUCTURE is_controller
      TO <lt_ctrl_exception_texts>.
    IF sy-subrc = 0.
      ASSIGN COMPONENT 'EXCPT' OF STRUCTURE ls_obj_old-wdyc TO <lt_excpt>.
      IF sy-subrc = 0.
        <lt_excpt> = <lt_ctrl_exception_texts>.
      ENDIF.
    ENDIF.
    ls_obj_old-wdyc-fgrps = is_controller-fieldgroups.

    CALL FUNCTION 'SVRS_MAKE_OBJECT_DELTA'
      EXPORTING
        obj_old              = ls_obj_new
        obj_new              = ls_obj_old
      CHANGING
        delta                = rs_delta
      EXCEPTIONS
        inconsistent_objects = 1.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from SVRS_MAKE_OBJECT_DELTA' ).
    ENDIF.

  ENDMETHOD.