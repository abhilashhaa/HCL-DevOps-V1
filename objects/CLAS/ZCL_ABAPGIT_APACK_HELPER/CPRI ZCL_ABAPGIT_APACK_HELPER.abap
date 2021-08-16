  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_manifest_declaration,
        clsname  TYPE seometarel-clsname,
        devclass TYPE devclass,
      END OF ty_manifest_declaration,
      tt_manifest_declaration TYPE STANDARD TABLE OF ty_manifest_declaration WITH NON-UNIQUE DEFAULT KEY.

    TYPES:
      BEGIN OF ty_dependency_status,
        met TYPE zif_abapgit_definitions=>ty_yes_no_partial.
        INCLUDE TYPE zif_abapgit_apack_definitions=>ty_dependency.
    TYPES: END OF ty_dependency_status,
      tt_dependency_status TYPE STANDARD TABLE OF ty_dependency_status WITH NON-UNIQUE DEFAULT KEY.

    CLASS-METHODS get_dependencies_met_status
      IMPORTING
        !it_dependencies TYPE zif_abapgit_apack_definitions=>tt_dependencies
      RETURNING
        VALUE(rt_status) TYPE tt_dependency_status
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS get_installed_packages
      RETURNING
        VALUE(rt_packages) TYPE zif_abapgit_apack_definitions=>tt_descriptor
      RAISING
        zcx_abapgit_exception.

    CLASS-METHODS show_dependencies_popup
      IMPORTING
        !it_dependencies TYPE tt_dependency_status
      RAISING
        zcx_abapgit_exception.
