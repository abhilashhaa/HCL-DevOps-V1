CLASS zcl_abapgit_state DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS:
      reduce
        IMPORTING
          !iv_cur  TYPE char1
        CHANGING
          !cv_prev TYPE char1 .
