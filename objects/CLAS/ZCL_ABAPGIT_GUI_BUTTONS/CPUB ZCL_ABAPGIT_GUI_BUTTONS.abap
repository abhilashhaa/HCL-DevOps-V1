CLASS zcl_abapgit_gui_buttons DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS new_online
      RETURNING VALUE(rv_html_string) TYPE string.

    CLASS-METHODS new_offline
      RETURNING VALUE(rv_html_string) TYPE string.

    CLASS-METHODS advanced
      RETURNING VALUE(rv_html_string) TYPE string.

    CLASS-METHODS help
      RETURNING VALUE(rv_html_string) TYPE string.

    CLASS-METHODS repo_list
      RETURNING VALUE(rv_html_string) TYPE string.

    CLASS-METHODS settings
      RETURNING VALUE(rv_html_string) TYPE string.
