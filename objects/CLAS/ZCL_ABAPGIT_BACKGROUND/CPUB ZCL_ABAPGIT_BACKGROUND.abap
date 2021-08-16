CLASS zcl_abapgit_background DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_methods,
             class       TYPE seoclsname,
             description TYPE string,
           END OF ty_methods.

    TYPES: ty_methods_tt TYPE SORTED TABLE OF ty_methods WITH UNIQUE KEY class.

    CLASS-METHODS run
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS list_methods
      RETURNING VALUE(rt_methods) TYPE ty_methods_tt.