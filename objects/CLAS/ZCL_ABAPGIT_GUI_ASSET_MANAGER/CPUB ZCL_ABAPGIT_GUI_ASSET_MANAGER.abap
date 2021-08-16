CLASS zcl_abapgit_gui_asset_manager DEFINITION PUBLIC FINAL CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_gui_asset_manager.

    TYPES:
      BEGIN OF ty_asset_entry.
        INCLUDE TYPE zif_abapgit_gui_asset_manager~ty_web_asset.
    TYPES: mime_name TYPE wwwdatatab-objid,
           END OF ty_asset_entry ,
           tt_asset_register TYPE STANDARD TABLE OF ty_asset_entry WITH KEY url.

    METHODS register_asset
      IMPORTING
        !iv_url       TYPE string
        !iv_type      TYPE string
        !iv_cachable  TYPE abap_bool DEFAULT abap_true
        !iv_mime_name TYPE wwwdatatab-objid OPTIONAL
        !iv_base64    TYPE string OPTIONAL
        !iv_inline    TYPE string OPTIONAL .
