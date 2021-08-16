CLASS zcl_abapgit_gui_component DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF c_html_parts,
        scripts      TYPE string VALUE 'scripts',
        hidden_forms TYPE string VALUE 'hidden_forms',
      END OF c_html_parts.
