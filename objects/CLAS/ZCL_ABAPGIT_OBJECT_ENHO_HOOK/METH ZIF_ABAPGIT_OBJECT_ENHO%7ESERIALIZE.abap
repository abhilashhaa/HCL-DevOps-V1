  METHOD zif_abapgit_object_enho~serialize.

    DATA: lv_shorttext       TYPE string,
          lo_hook_impl       TYPE REF TO cl_enh_tool_hook_impl,
          ls_original_object TYPE enh_hook_admin,
          lt_spaces          TYPE ty_spaces_tt,
          lt_enhancements    TYPE enh_hook_impl_it.

    FIELD-SYMBOLS: <ls_enhancement> LIKE LINE OF lt_enhancements.


    lo_hook_impl ?= ii_enh_tool.

    lv_shorttext = lo_hook_impl->if_enh_object_docu~get_shorttext( ).
    lo_hook_impl->get_original_object(
      IMPORTING
        pgmid     = ls_original_object-pgmid
        obj_name  = ls_original_object-org_obj_name
        obj_type  = ls_original_object-org_obj_type
        main_type = ls_original_object-org_main_type
        main_name = ls_original_object-org_main_name
        program   = ls_original_object-programname ).
    ls_original_object-include_bound = lo_hook_impl->get_include_bound( ).
    lt_enhancements = lo_hook_impl->get_hook_impls( ).

    LOOP AT lt_enhancements ASSIGNING <ls_enhancement>.
      CLEAR: <ls_enhancement>-extid,
             <ls_enhancement>-id.
    ENDLOOP.

    ii_xml->add( iv_name = 'TOOL'
                 ig_data = ii_enh_tool->get_tool( ) ).
    ii_xml->add( ig_data = lv_shorttext
                 iv_name = 'SHORTTEXT' ).
    ii_xml->add( ig_data = ls_original_object
                 iv_name = 'ORIGINAL_OBJECT' ).
    ii_xml->add( iv_name = 'ENHANCEMENTS'
                 ig_data = lt_enhancements ).
    ii_xml->add( iv_name = 'SPACES'
                 ig_data = lt_spaces ).

  ENDMETHOD.