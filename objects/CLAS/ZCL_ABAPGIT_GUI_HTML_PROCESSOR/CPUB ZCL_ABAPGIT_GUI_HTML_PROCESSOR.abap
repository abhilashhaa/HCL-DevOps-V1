CLASS zcl_abapgit_gui_html_processor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS c_css_build_name TYPE string VALUE 'css/bundle.css'.
    CONSTANTS c_preprocess_marker TYPE string VALUE `<!-- abapgit HTML preprocessor -->`.
    CONSTANTS c_comment_start TYPE string VALUE `<!--`.
    CONSTANTS c_comment_end TYPE string VALUE `-->`.

    INTERFACES zif_abapgit_gui_html_processor .

    METHODS constructor
      IMPORTING
        ii_asset_man TYPE REF TO zif_abapgit_gui_asset_manager.

    METHODS preserve_css
      IMPORTING
        !iv_css_url TYPE string .
