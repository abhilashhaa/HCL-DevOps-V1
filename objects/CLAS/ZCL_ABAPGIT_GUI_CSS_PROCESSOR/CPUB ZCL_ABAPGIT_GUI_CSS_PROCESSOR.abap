CLASS zcl_abapgit_gui_css_processor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          ii_asset_manager TYPE REF TO zif_abapgit_gui_asset_manager,
      add_file
        IMPORTING
          iv_url TYPE string,
      process
        RETURNING
          VALUE(rv_result) TYPE string
        RAISING   zcx_abapgit_exception.
