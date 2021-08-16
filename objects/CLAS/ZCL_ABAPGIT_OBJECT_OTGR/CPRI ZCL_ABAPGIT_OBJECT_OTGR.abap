  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_otgr,
        cls_type_group TYPE cls_type_group,
        texts          TYPE STANDARD TABLE OF cls_type_groupt WITH DEFAULT KEY,
        elements       TYPE STANDARD TABLE OF cls_tygr_element WITH DEFAULT KEY,
      END OF ty_otgr .

    METHODS instantiate_and_lock_otgr
      RETURNING
        VALUE(ro_otgr) TYPE REF TO cl_cls_object_type_group
      RAISING
        zcx_abapgit_exception .