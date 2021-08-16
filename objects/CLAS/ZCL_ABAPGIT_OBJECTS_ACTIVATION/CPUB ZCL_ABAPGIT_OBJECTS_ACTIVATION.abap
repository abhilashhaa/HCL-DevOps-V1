CLASS zcl_abapgit_objects_activation DEFINITION PUBLIC CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS add
      IMPORTING iv_type   TYPE trobjtype
                iv_name   TYPE clike
                iv_delete TYPE abap_bool DEFAULT abap_false
      RAISING   zcx_abapgit_exception.

    CLASS-METHODS add_item
      IMPORTING is_item TYPE zif_abapgit_definitions=>ty_item
      RAISING   zcx_abapgit_exception.

    CLASS-METHODS activate
      IMPORTING iv_ddic TYPE abap_bool DEFAULT abap_false
      RAISING   zcx_abapgit_exception.

    CLASS-METHODS clear.
