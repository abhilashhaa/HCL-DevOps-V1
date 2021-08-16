  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_s_manifest_declaration,
        clsname  TYPE seometarel-clsname,
        devclass TYPE devclass,
      END OF ty_s_manifest_declaration .

    DATA mv_package_name TYPE ty_package_name .
    DATA ms_cached_descriptor TYPE zif_abapgit_apack_definitions=>ty_descriptor .
    DATA mv_is_cached TYPE abap_bool .

    CLASS-METHODS from_xml
      IMPORTING
        iv_xml         TYPE string
      RETURNING
        VALUE(rs_data) TYPE zif_abapgit_apack_definitions=>ty_descriptor.

    METHODS format_version
      RAISING
        zcx_abapgit_exception.
