  METHOD delta_definition.

    DATA: ls_key       TYPE wdy_md_component_key,
          lv_found     TYPE abap_bool,
          ls_obj_new   TYPE svrs2_versionable_object,
          li_component TYPE REF TO if_wdy_md_component,
          ls_obj_old   TYPE svrs2_versionable_object.


    ls_key-component_name = is_definition-definition-component_name.

    lv_found = cl_wdy_md_component=>check_existency( ls_key-component_name ).
    IF lv_found = abap_false.
      TRY.
          cl_wdy_md_component=>create_complete(
            EXPORTING
              name      = ls_key-component_name
            IMPORTING
              component = li_component
            CHANGING
              devclass  = iv_package ).
          li_component->save_to_database( ).
          li_component->unlock( ).
        CATCH cx_wdy_md_exception.
          zcx_abapgit_exception=>raise( 'error creating dummy component' ).
      ENDTRY.
    ENDIF.

    ls_obj_new-objtype = wdyn_limu_component_definition.
    ls_obj_new-objname = ls_key-component_name.

    ls_obj_old-objtype = wdyn_limu_component_definition.
    ls_obj_old-objname = ls_key-component_name.

    APPEND is_definition-definition TO ls_obj_old-wdyd-defin.
    ls_obj_old-wdyd-descr = is_definition-descriptions.
    ls_obj_old-wdyd-cusag = is_definition-component_usages.
    ls_obj_old-wdyd-intrf = is_definition-interface_implementings.
    ls_obj_old-wdyd-libra = is_definition-library_usages.
    ls_obj_old-wdyd-ctuse = is_definition-ext_ctlr_usages.
    ls_obj_old-wdyd-ctmap = is_definition-ext_ctx_mappings.

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