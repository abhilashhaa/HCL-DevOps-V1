  PROTECTED SECTION.
    CLASS-METHODS:
      convert_attrib_to_vseoattrib
        IMPORTING iv_clsname           TYPE seoclsname
                  it_attributes        TYPE zif_abapgit_definitions=>ty_obj_attribute_tt
        RETURNING VALUE(rt_vseoattrib) TYPE seoo_attributes_r.
