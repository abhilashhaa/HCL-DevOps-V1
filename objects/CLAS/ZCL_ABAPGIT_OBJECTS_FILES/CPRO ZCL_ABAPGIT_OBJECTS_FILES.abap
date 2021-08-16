  PROTECTED SECTION.

    METHODS read_file
      IMPORTING
        !iv_filename   TYPE string
        !iv_error      TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(rv_data) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    METHODS filename
      IMPORTING
        !iv_extra          TYPE clike OPTIONAL
        !iv_ext            TYPE string
      RETURNING
        VALUE(rv_filename) TYPE string .