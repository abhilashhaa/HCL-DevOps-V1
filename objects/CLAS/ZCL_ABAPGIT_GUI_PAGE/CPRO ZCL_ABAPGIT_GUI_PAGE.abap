  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_control,
        page_title TYPE string,
        page_menu  TYPE REF TO zcl_abapgit_html_toolbar,
      END OF  ty_control .

    DATA ms_control TYPE ty_control .

    METHODS render_content
          ABSTRACT
      RETURNING
        VALUE(ri_html) TYPE REF TO zif_abapgit_html
      RAISING
        zcx_abapgit_exception .