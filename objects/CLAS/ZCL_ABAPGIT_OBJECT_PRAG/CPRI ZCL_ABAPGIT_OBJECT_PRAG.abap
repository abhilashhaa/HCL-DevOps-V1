  PRIVATE SECTION.
    TYPES: BEGIN OF ty_pragma,
             pragma      TYPE c LENGTH 40,
             extension   TYPE c LENGTH 1,
             signature   TYPE c LENGTH 10,
             description TYPE c LENGTH 255,
           END OF ty_pragma.

    METHODS:
      _raise_pragma_not_exists
        RAISING
          zcx_abapgit_exception,

      _raise_pragma_exists
        RAISING
          zcx_abapgit_exception,

      _raise_pragma_enqueue
        RAISING
          zcx_abapgit_exception.
