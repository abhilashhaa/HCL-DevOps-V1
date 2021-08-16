  PROTECTED SECTION.
    METHODS get_generic
      RETURNING
        VALUE(ro_generic) TYPE REF TO zcl_abapgit_objects_generic
      RAISING
        zcx_abapgit_exception.

    METHODS after_import
      RAISING
        zcx_abapgit_exception.

    METHODS delete_tadir_cdnames
      IMPORTING
        !is_cdnames TYPE cdnames
      RAISING
        zcx_abapgit_exception.

    METHODS delete_tadir_tabl
      IMPORTING
        !is_tcdrs TYPE tcdrs
      RAISING
        zcx_abapgit_exception.
