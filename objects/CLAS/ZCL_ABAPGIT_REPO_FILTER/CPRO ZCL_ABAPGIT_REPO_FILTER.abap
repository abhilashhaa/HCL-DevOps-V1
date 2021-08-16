  PROTECTED SECTION.
    METHODS get_package
      RETURNING
        VALUE(rv_package) TYPE devclass.

    METHODS filter_generated_tadir
      CHANGING
        ct_tadir TYPE zif_abapgit_definitions=>ty_tadir_tt.
