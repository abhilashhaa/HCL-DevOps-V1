  PRIVATE SECTION.

    CONSTANTS c_layout_file_ext TYPE string VALUE 'xdp'.

    METHODS:
      load
        RETURNING VALUE(ri_wb_form) TYPE REF TO if_fp_wb_form
        RAISING   zcx_abapgit_exception,
      form_to_xstring
        RETURNING VALUE(rv_xstr) TYPE xstring
        RAISING   zcx_abapgit_exception.
