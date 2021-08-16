  PRIVATE SECTION.

    CLASS-METHODS show_requirement_popup
      IMPORTING
        !it_requirements TYPE ty_requirement_status_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_requirement_met_status
      IMPORTING
        !it_requirements TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt
      RETURNING
        VALUE(rt_status) TYPE ty_requirement_status_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS version_greater_or_equal
      IMPORTING
        !is_status     TYPE ty_requirement_status
      RETURNING
        VALUE(rv_true) TYPE abap_bool .