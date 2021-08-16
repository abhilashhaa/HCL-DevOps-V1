  METHOD deserialize_abap.
    DATA: ls_vseointerf   TYPE vseointerf,
          lt_source       TYPE seop_source_string,
          lt_descriptions TYPE zif_abapgit_definitions=>ty_seocompotx_tt,
          ls_clskey       TYPE seoclskey.


    ls_clskey-clsname = ms_item-obj_name.
    lt_source = mo_files->read_abap( ).
    ii_xml->read( EXPORTING iv_name = 'VSEOINTERF'
                  CHANGING cg_data = ls_vseointerf ).

    mi_object_oriented_object_fct->create(
      EXPORTING
        iv_package    = iv_package
      CHANGING
        cg_properties = ls_vseointerf ).

    mi_object_oriented_object_fct->deserialize_source(
      is_key               = ls_clskey
      it_source            = lt_source ).

    ii_xml->read( EXPORTING iv_name = 'DESCRIPTIONS'
                  CHANGING cg_data = lt_descriptions ).

    mi_object_oriented_object_fct->update_descriptions(
      is_key          = ls_clskey
      it_descriptions = lt_descriptions ).

    mi_object_oriented_object_fct->add_to_activation_list( ms_item ).
  ENDMETHOD.