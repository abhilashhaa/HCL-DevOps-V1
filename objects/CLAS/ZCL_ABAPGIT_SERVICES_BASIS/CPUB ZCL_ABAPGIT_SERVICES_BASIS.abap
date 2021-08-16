CLASS zcl_abapgit_services_basis DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS create_package
      IMPORTING
        iv_prefill_package TYPE devclass OPTIONAL
      RETURNING
        VALUE(rv_package)  TYPE devclass
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS test_changed_by
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS run_performance_test
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS open_ie_devtools
      RAISING
        zcx_abapgit_exception.
