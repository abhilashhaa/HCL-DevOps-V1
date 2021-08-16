  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_msg,
        msgv1 TYPE symsgv,
        msgv2 TYPE symsgv,
        msgv3 TYPE symsgv,
        msgv4 TYPE symsgv,
      END OF ty_msg .

    DATA:
      mo_exception TYPE REF TO zcx_abapgit_exception,
      ms_t100key   TYPE scx_t100key.

    CLASS-METHODS split_text
      IMPORTING
        !iv_text      TYPE string
      RETURNING
        VALUE(rs_msg) TYPE ty_msg .
    METHODS itf_to_string
      IMPORTING
        !it_itf          TYPE tline_tab
      RETURNING
        VALUE(rv_result) TYPE string .
    METHODS get_t100_longtext_itf
      RETURNING
        VALUE(rt_itf) TYPE tline_tab .
    METHODS remove_empty_section
      IMPORTING
        !iv_tabix_from TYPE i
        !iv_tabix_to   TYPE i
      CHANGING
        !ct_itf        TYPE tline_tab .
    METHODS replace_section_head_with_text
      CHANGING
        !cs_itf TYPE tline .
    METHODS set_single_msg_var
      IMPORTING
        !iv_arg          TYPE clike
      RETURNING
        VALUE(rv_target) TYPE symsgv .
    METHODS set_single_msg_var_clike
      IMPORTING
        !iv_arg          TYPE clike
      RETURNING
        VALUE(rv_target) TYPE symsgv .
    METHODS set_single_msg_var_numeric
      IMPORTING
        !iv_arg          TYPE numeric
      RETURNING
        VALUE(rv_target) TYPE symsgv .
    METHODS set_single_msg_var_xseq
      IMPORTING
        !iv_arg          TYPE xsequence
      RETURNING
        VALUE(rv_target) TYPE symsgv .