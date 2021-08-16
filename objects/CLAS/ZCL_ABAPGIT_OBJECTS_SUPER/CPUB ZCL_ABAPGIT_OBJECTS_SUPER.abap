CLASS zcl_abapgit_objects_super DEFINITION PUBLIC ABSTRACT.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          is_item     TYPE zif_abapgit_definitions=>ty_item
          iv_language TYPE spras.

    CLASS-METHODS:
      jump_adt
        IMPORTING iv_obj_name     TYPE zif_abapgit_definitions=>ty_item-obj_name
                  iv_obj_type     TYPE zif_abapgit_definitions=>ty_item-obj_type
                  iv_sub_obj_name TYPE zif_abapgit_definitions=>ty_item-obj_name OPTIONAL
                  iv_sub_obj_type TYPE zif_abapgit_definitions=>ty_item-obj_type OPTIONAL
                  iv_line_number  TYPE i OPTIONAL
        RAISING   zcx_abapgit_exception.

    CONSTANTS: c_user_unknown TYPE xubname VALUE 'UNKNOWN'.
