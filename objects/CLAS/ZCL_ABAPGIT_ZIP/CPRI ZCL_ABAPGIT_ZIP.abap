  PRIVATE SECTION.

    CLASS-METHODS encode_files
      IMPORTING
        !it_files      TYPE zif_abapgit_definitions=>ty_files_item_tt
      RETURNING
        VALUE(rv_xstr) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS filename
      IMPORTING
        !iv_str      TYPE string
      EXPORTING
        !ev_path     TYPE string
        !ev_filename TYPE string
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS normalize_path
      CHANGING
        !ct_files TYPE zif_abapgit_definitions=>ty_files_tt
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS unzip_file
      IMPORTING
        !iv_xstr        TYPE xstring
      RETURNING
        VALUE(rt_files) TYPE zif_abapgit_definitions=>ty_files_tt
      RAISING
        zcx_abapgit_exception .