  PRIVATE SECTION.
    METHODS read
      EXPORTING es_app        TYPE wdy_application
                et_properties TYPE wdy_app_property_table
      RAISING   zcx_abapgit_exception.

    METHODS save
      IMPORTING is_app        TYPE wdy_application
                it_properties TYPE wdy_app_property_table
                iv_package    TYPE devclass
      RAISING   zcx_abapgit_exception.
