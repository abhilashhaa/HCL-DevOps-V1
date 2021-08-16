  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_dependency,
        depname  TYPE dd02l-tabname,
        deptyp   TYPE c LENGTH 4,
        deplocal TYPE dd02l-as4local,
        refname  TYPE dd02l-tabname,
        reftyp   TYPE c LENGTH 4,
        kind     TYPE c LENGTH 1,
      END OF ty_dependency .
    TYPES:
      tty_dedenpency TYPE STANDARD TABLE OF ty_dependency
                                 WITH NON-UNIQUE DEFAULT KEY .
    TYPES:
      BEGIN OF ty_item,
        obj_type TYPE tadir-object,
        obj_name TYPE tadir-obj_name,
        devclass TYPE devclass,
      END OF ty_item .

    CLASS-METHODS resolve_ddic
      CHANGING
        !ct_tadir TYPE zif_abapgit_definitions=>ty_tadir_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_ddls_dependencies
      IMPORTING
        iv_ddls_name         TYPE tadir-obj_name
      RETURNING
        VALUE(rt_dependency) TYPE tty_dedenpency .
    CLASS-METHODS resolve_packages
      CHANGING
        ct_tadir TYPE zif_abapgit_definitions=>ty_tadir_tt.