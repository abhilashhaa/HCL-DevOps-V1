  PROTECTED SECTION.

    METHODS register_deferred_script
      IMPORTING
        ii_part TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception.
    METHODS gui_services
      RETURNING
        VALUE(ri_gui_services) TYPE REF TO zif_abapgit_gui_services
      RAISING
        zcx_abapgit_exception.
