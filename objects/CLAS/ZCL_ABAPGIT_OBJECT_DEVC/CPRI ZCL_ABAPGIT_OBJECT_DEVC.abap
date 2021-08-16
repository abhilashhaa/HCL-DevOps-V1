  PRIVATE SECTION.
    METHODS:
      get_package RETURNING VALUE(ri_package) TYPE REF TO if_package
                  RAISING   zcx_abapgit_exception,
      update_pinf_usages IMPORTING ii_package    TYPE REF TO if_package
                                   it_usage_data TYPE scomppdata
                         RAISING   zcx_abapgit_exception,
      set_lock IMPORTING ii_package TYPE REF TO if_package
                         iv_lock    TYPE abap_bool
               RAISING   zcx_abapgit_exception,
      is_empty
        IMPORTING iv_package_name    TYPE devclass
        RETURNING VALUE(rv_is_empty) TYPE abap_bool
        RAISING   zcx_abapgit_exception,
      load_package
        IMPORTING iv_package_name   TYPE devclass
        RETURNING VALUE(ri_package) TYPE REF TO if_package
        RAISING   zcx_abapgit_exception.

    DATA:
      mv_local_devclass TYPE devclass.