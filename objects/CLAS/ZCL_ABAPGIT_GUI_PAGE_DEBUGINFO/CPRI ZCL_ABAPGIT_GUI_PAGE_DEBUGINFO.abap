  PRIVATE SECTION.

    METHODS get_jump_class
      IMPORTING
        !iv_class      TYPE seoclsname
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS render_debug_info
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .
    METHODS render_supported_object_types
      RETURNING
        VALUE(rv_html) TYPE string .
    METHODS render_scripts
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .