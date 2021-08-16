  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_char,
        cls_attribute   TYPE cls_attribute,
        cls_attributet  TYPE STANDARD TABLE OF cls_attributet WITH DEFAULT KEY,
        cls_attr_value  TYPE STANDARD TABLE OF cls_attr_value WITH DEFAULT KEY,
        cls_attr_valuet TYPE STANDARD TABLE OF cls_attr_valuet WITH DEFAULT KEY,
      END OF ty_char .

    METHODS instantiate_char_and_lock
      IMPORTING
        !iv_type_group       TYPE cls_object_type_group
        !iv_activation_state TYPE pak_activation_state
      RETURNING
        VALUE(ro_char)       TYPE REF TO cl_cls_attribute
      RAISING
        zcx_abapgit_exception .