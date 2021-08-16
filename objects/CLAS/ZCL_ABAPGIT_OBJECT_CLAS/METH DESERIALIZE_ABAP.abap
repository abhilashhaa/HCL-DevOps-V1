  METHOD deserialize_abap.
* same as in zcl_abapgit_object_clas, but without "mo_object_oriented_object_fct->add_to_activation_list"

    DATA: ls_vseoclass             TYPE vseoclass,
          lt_source                TYPE seop_source_string,
          lt_local_definitions     TYPE seop_source_string,
          lt_local_implementations TYPE seop_source_string,
          lt_local_macros          TYPE seop_source_string,
          lt_test_classes          TYPE seop_source_string,
          lt_descriptions          TYPE zif_abapgit_definitions=>ty_seocompotx_tt,
          ls_class_key             TYPE seoclskey,
          lt_attributes            TYPE zif_abapgit_definitions=>ty_obj_attribute_tt.


    lt_source = mo_files->read_abap( ).

    lt_local_definitions = mo_files->read_abap( iv_extra = 'locals_def'
                                                iv_error = abap_false ).

    lt_local_implementations = mo_files->read_abap( iv_extra = 'locals_imp'
                                                    iv_error = abap_false ).

    lt_local_macros = mo_files->read_abap( iv_extra = 'macros'
                                           iv_error = abap_false ).

    lt_test_classes = mo_files->read_abap( iv_extra = 'testclasses'
                                           iv_error = abap_false ).

    ls_class_key-clsname = ms_item-obj_name.

    ii_xml->read( EXPORTING iv_name = 'VSEOCLASS'
                  CHANGING  cg_data = ls_vseoclass ).

    ii_xml->read( EXPORTING iv_name = 'ATTRIBUTES'
                  CHANGING  cg_data = lt_attributes ).

    mi_object_oriented_object_fct->create(
      EXPORTING
        iv_package    = iv_package
        it_attributes = lt_attributes
      CHANGING
        cg_properties = ls_vseoclass ).

    mi_object_oriented_object_fct->generate_locals(
      is_key                   = ls_class_key
      iv_force                 = abap_true
      it_local_definitions     = lt_local_definitions
      it_local_implementations = lt_local_implementations
      it_local_macros          = lt_local_macros
      it_local_test_classes    = lt_test_classes ).

    repo_apack_replacement( CHANGING ct_source = lt_source ).
    mi_object_oriented_object_fct->deserialize_source(
      is_key    = ls_class_key
      it_source = lt_source ).

    ii_xml->read( EXPORTING iv_name = 'DESCRIPTIONS'
                  CHANGING cg_data = lt_descriptions ).

    mi_object_oriented_object_fct->update_descriptions(
      is_key          = ls_class_key
      it_descriptions = lt_descriptions ).

  ENDMETHOD.