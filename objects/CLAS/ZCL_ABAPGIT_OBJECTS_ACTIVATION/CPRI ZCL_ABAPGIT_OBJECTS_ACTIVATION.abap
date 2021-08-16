  PRIVATE SECTION.

    CLASS-DATA:
      gt_classes TYPE STANDARD TABLE OF seoclsname WITH DEFAULT KEY .
    CLASS-DATA:
      gt_objects TYPE TABLE OF dwinactiv .

    CLASS-METHODS update_where_used .
    CLASS-METHODS use_new_activation_logic
      RETURNING
        VALUE(rv_use_new_activation_logic) TYPE abap_bool .
    CLASS-METHODS activate_new
      IMPORTING
        !iv_ddic TYPE abap_bool DEFAULT abap_false
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS activate_old
      IMPORTING
        !iv_ddic TYPE abap_bool DEFAULT abap_false
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS activate_ddic
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS show_activation_errors
      IMPORTING
        !iv_logname TYPE ddmass-logname
      RAISING
        zcx_abapgit_exception .