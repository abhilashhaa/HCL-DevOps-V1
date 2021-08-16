  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_header,
        guid      TYPE guid_32,
        attribute TYPE cls_attribute_name,
        object    TYPE pak_object_key,
      END OF ty_header .
    TYPES:
      BEGIN OF ty_avas,
        header TYPE ty_header,
        values TYPE cls_value_assignments,
        links  TYPE cls_linked_objects,
      END OF ty_avas .

    METHODS insert_assignments
      IMPORTING
        !is_avas TYPE ty_avas
      RAISING
        zcx_abapgit_exception .
    METHODS instantiate
      RETURNING
        VALUE(ro_avas) TYPE REF TO cl_cls_attr_value_assignment
      RAISING
        zcx_abapgit_exception .