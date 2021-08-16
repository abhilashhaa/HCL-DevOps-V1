  PROTECTED SECTION.

    METHODS get_parent
      IMPORTING
        !iv_package      TYPE devclass
      RETURNING
        VALUE(rv_parent) TYPE devclass
      RAISING
        zcx_abapgit_exception .