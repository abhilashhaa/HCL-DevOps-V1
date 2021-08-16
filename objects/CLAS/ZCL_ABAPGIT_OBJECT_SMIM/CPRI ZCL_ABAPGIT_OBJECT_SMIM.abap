  PRIVATE SECTION.
    METHODS get_filename
      IMPORTING iv_url             TYPE string
      RETURNING VALUE(rv_filename) TYPE string.

    METHODS find_content
      IMPORTING iv_url            TYPE string
      RETURNING VALUE(rv_content) TYPE xstring
      RAISING   zcx_abapgit_exception.

    METHODS build_filename
      IMPORTING iv_filename        TYPE string
      RETURNING VALUE(rv_filename) TYPE string.

    METHODS get_url_for_io
      EXPORTING ev_url       TYPE string
                ev_is_folder TYPE abap_bool
      RAISING   zcx_abapgit_not_found
                zcx_abapgit_exception.
