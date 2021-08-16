  METHOD serialize_attr.

    DATA: lt_attributes TYPE zif_abapgit_definitions=>ty_obj_attribute_tt.

    lt_attributes = mi_object_oriented_object_fct->read_attributes( iv_clsname ).
    IF lines( lt_attributes ) = 0.
      RETURN.
    ENDIF.

    ii_xml->add( iv_name = 'ATTRIBUTES'
                 ig_data = lt_attributes ).

  ENDMETHOD.