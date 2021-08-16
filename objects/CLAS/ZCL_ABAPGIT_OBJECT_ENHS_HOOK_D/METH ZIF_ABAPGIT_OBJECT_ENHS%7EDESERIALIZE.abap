  METHOD zif_abapgit_object_enhs~deserialize.

    DATA: lv_enh_shorttext       TYPE string,
          ls_enh_hook_definition TYPE enh_hook_def,
          ls_hook_definition     TYPE ty_hook_defifnition,
          li_enh_object          TYPE REF TO if_enh_object,
          li_enh_object_docu     TYPE REF TO if_enh_object_docu,
          lo_hookdef_tool        TYPE REF TO cl_enh_tool_hook_def,
          lx_error               TYPE REF TO cx_enh_root,
          lv_text                TYPE string.

    FIELD-SYMBOLS: <ls_hook_definition> TYPE enh_hook_def_ext.

    ii_xml->read( EXPORTING iv_name = 'SHORTTEXT'
                  CHANGING  cg_data = lv_enh_shorttext ).

    ii_xml->read( EXPORTING iv_name = 'BADI_DATA'
                  CHANGING  cg_data = ls_hook_definition ).

    li_enh_object ?= ii_enh_spot_tool.
    li_enh_object_docu ?= ii_enh_spot_tool.

    TRY.
        li_enh_object_docu->set_shorttext( lv_enh_shorttext ).

        lo_hookdef_tool ?= ii_enh_spot_tool.

        lo_hookdef_tool->set_original_object( pgmid     = ls_hook_definition-pgmid
                                              obj_name  = ls_hook_definition-obj_name
                                              obj_type  = ls_hook_definition-obj_type
                                              program   = ls_hook_definition-program
                                              main_type = ls_hook_definition-main_type
                                              main_name = ls_hook_definition-main_name ).

        LOOP AT ls_hook_definition-def_hooks ASSIGNING <ls_hook_definition>.
          MOVE-CORRESPONDING <ls_hook_definition> TO ls_enh_hook_definition.
          lo_hookdef_tool->add_hook_def( ls_enh_hook_definition ).
        ENDLOOP.

        li_enh_object->save( ).
        li_enh_object->activate( ).
        li_enh_object->unlock( ).

      CATCH cx_enh_root INTO lx_error.
        lv_text = lx_error->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.