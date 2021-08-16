CLASS zcl_abapgit_repo_filter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        !iv_package TYPE devclass.

    METHODS apply
      IMPORTING
        it_filter TYPE zif_abapgit_definitions=>ty_tadir_tt
      CHANGING
        ct_tadir  TYPE zif_abapgit_definitions=>ty_tadir_tt .
