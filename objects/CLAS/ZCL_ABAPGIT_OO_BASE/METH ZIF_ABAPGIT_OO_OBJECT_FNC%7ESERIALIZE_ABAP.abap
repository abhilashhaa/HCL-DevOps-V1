  METHOD zif_abapgit_oo_object_fnc~serialize_abap.
    DATA lo_oo_serializer TYPE REF TO zcl_abapgit_oo_serializer.
    CREATE OBJECT lo_oo_serializer.
    CASE iv_type.
      WHEN seop_ext_class_locals_def.
        rt_source = lo_oo_serializer->serialize_locals_def( is_class_key ).
      WHEN seop_ext_class_locals_imp.
        rt_source = lo_oo_serializer->serialize_locals_imp( is_class_key ).
      WHEN seop_ext_class_macros.
        rt_source = lo_oo_serializer->serialize_macros( is_class_key ).
      WHEN seop_ext_class_testclasses.
        rt_source = lo_oo_serializer->serialize_testclasses( is_class_key ).
        mv_skip_test_classes = lo_oo_serializer->are_test_classes_skipped( ).
      WHEN OTHERS.
        rt_source = lo_oo_serializer->serialize_abap_clif_source( is_class_key ).
    ENDCASE.
  ENDMETHOD.