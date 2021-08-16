  METHOD recover_definition.

    DATA: ls_key    TYPE wdy_md_component_key,
          lv_corrnr TYPE trkorr,
          ls_delta  TYPE svrs2_xversionable_object.


    ls_delta = delta_definition(
      is_definition = is_definition
      iv_package    = iv_package ).

    ls_key-component_name = is_definition-definition-component_name.

    TRY.
        cl_wdy_md_component=>recover_version(
          EXPORTING
            component_key = ls_key
            delta         = ls_delta-wdyd
          CHANGING
            corrnr        = lv_corrnr ).
      CATCH cx_wdy_md_exception.
        zcx_abapgit_exception=>raise( 'error recovering version of component' ).
    ENDTRY.

  ENDMETHOD.