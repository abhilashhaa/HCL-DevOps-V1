  PRIVATE SECTION.
    CLASS-METHODS do_install
      IMPORTING iv_title   TYPE c
                iv_text    TYPE c
                iv_url     TYPE string
                iv_package TYPE devclass
      RAISING   zcx_abapgit_exception.

    CLASS-METHODS set_start_repo_from_package
      IMPORTING
        iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS get_package_from_adt
      RETURNING
        VALUE(rv_package) TYPE devclass.
    CLASS-METHODS check_sapgui
      RAISING
        zcx_abapgit_exception.
