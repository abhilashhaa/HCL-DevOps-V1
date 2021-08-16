  PRIVATE SECTION.
    CONSTANTS: c_prefix TYPE c LENGTH 3 VALUE '%_C'.

    METHODS read
      EXPORTING ev_ddtext TYPE ddtypet-ddtext
                et_source TYPE abaptxt255_tab
      RAISING   zcx_abapgit_not_found.

    METHODS create
      IMPORTING iv_ddtext   TYPE ddtypet-ddtext
                it_source   TYPE abaptxt255_tab
                iv_devclass TYPE devclass
      RAISING   zcx_abapgit_exception.
