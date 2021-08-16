  METHOD serialize_xml.
    DATA:
      lt_descriptions TYPE zif_abapgit_definitions=>ty_seocompotx_tt,
      ls_vseointerf   TYPE vseointerf,
      ls_clskey       TYPE seoclskey,
      lt_lines        TYPE tlinetab,
      lv_language     TYPE spras.


    ls_clskey-clsname = ms_item-obj_name.

    ls_vseointerf = mi_object_oriented_object_fct->get_interface_properties( ls_clskey ).

    CLEAR: ls_vseointerf-uuid,
           ls_vseointerf-author,
           ls_vseointerf-createdon,
           ls_vseointerf-changedby,
           ls_vseointerf-changedon,
           ls_vseointerf-chgdanyby,
           ls_vseointerf-chgdanyon,
           ls_vseointerf-r3release,
           ls_vseointerf-version.

    io_xml->add( iv_name = 'VSEOINTERF'
                 ig_data = ls_vseointerf ).

    lt_lines = mi_object_oriented_object_fct->read_documentation(
      iv_class_name = ls_clskey-clsname
      iv_language   = mv_language ).
    IF lines( lt_lines ) > 0.
      io_xml->add( iv_name = 'LINES'
                   ig_data = lt_lines ).
    ENDIF.

    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      lv_language = mv_language.
    ENDIF.

    lt_descriptions = mi_object_oriented_object_fct->read_descriptions(
      iv_obejct_name = ls_clskey-clsname
      iv_language = lv_language ).

    IF lines( lt_descriptions ) > 0.
      io_xml->add( iv_name = 'DESCRIPTIONS'
                   ig_data = lt_descriptions ).
    ENDIF.
  ENDMETHOD.