CLASS zcl_abapgit_dependencies DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS resolve
      CHANGING
        !ct_tadir TYPE zif_abapgit_definitions=>ty_tadir_tt
      RAISING
        zcx_abapgit_exception .