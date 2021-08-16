  PRIVATE SECTION.
    TYPES:
      tty_param_values TYPE STANDARD TABLE OF rsparam
                                     WITH NON-UNIQUE DEFAULT KEY ,
      tty_tstca        TYPE STANDARD TABLE OF tstca
                                     WITH DEFAULT KEY.

    CONSTANTS:
      c_oo_program   TYPE c LENGTH 9 VALUE '\PROGRAM=' ##NO_TEXT,
      c_oo_class     TYPE c LENGTH 7 VALUE '\CLASS=' ##NO_TEXT,
      c_oo_method    TYPE c LENGTH 8 VALUE '\METHOD=' ##NO_TEXT,
      c_oo_tcode     TYPE tcode VALUE 'OS_APPLICATION' ##NO_TEXT,
      c_oo_frclass   TYPE c LENGTH 30 VALUE 'CLASS' ##NO_TEXT,
      c_oo_frmethod  TYPE c LENGTH 30 VALUE 'METHOD' ##NO_TEXT,
      c_oo_frupdtask TYPE c LENGTH 30 VALUE 'UPDATE_MODE' ##NO_TEXT,
      c_oo_synchron  TYPE c VALUE 'S' ##NO_TEXT,
      c_oo_asynchron TYPE c VALUE 'U' ##NO_TEXT,
      c_true         TYPE c VALUE 'X' ##NO_TEXT,
      c_false        TYPE c VALUE space ##NO_TEXT,
      BEGIN OF c_variant_type,
        dialog     TYPE rglif-docutype VALUE 'D' ##NO_TEXT,
        report     TYPE rglif-docutype VALUE 'R' ##NO_TEXT,
        variant    TYPE rglif-docutype VALUE 'V' ##NO_TEXT,
        parameters TYPE rglif-docutype VALUE 'P' ##NO_TEXT,
        object     TYPE rglif-docutype VALUE 'O' ##NO_TEXT,
      END OF c_variant_type.

    DATA:
      mt_bcdata TYPE STANDARD TABLE OF bdcdata .

    METHODS transaction_read
      IMPORTING
        iv_transaction TYPE tcode
      EXPORTING
        es_transaction TYPE tstc
        es_gui_attr    TYPE tstcc
      RAISING
        zcx_abapgit_exception.
    METHODS shift_param
      CHANGING
        !ct_rsparam TYPE s_param
        !cs_tstcp   TYPE tstcp .
    METHODS add_data
      IMPORTING
        !iv_fnam TYPE bdcdata-fnam
        !iv_fval TYPE clike .
    METHODS call_se93
      RAISING
        zcx_abapgit_exception .
    METHODS set_oo_parameters
      IMPORTING
        !it_rsparam TYPE s_param
      CHANGING
        !cs_rsstcd  TYPE rsstcd .
    METHODS split_parameters
      CHANGING
        !ct_rsparam TYPE s_param
        !cs_rsstcd  TYPE rsstcd
        !cs_tstcp   TYPE tstcp
        !cs_tstc    TYPE tstc .
    METHODS split_parameters_comp
      IMPORTING
        !ig_type  TYPE any
        !ig_param TYPE any
      CHANGING
        !cg_value TYPE any .
    METHODS serialize_texts
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_texts
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_oo_transaction
      IMPORTING
        !iv_package TYPE devclass
        !is_tstc    TYPE tstc
        !is_tstcc   TYPE tstcc
        !is_tstct   TYPE tstct
        !is_rsstcd  TYPE rsstcd
      RAISING
        zcx_abapgit_exception .
    METHODS save_authorizations
      IMPORTING
        iv_transaction    TYPE tstc-tcode
        it_authorizations TYPE tty_tstca
      RAISING
        zcx_abapgit_exception.
    METHODS clear_functiongroup_globals.
    METHODS is_variant_transaction IMPORTING is_tstcp                      TYPE tstcp
                                   RETURNING VALUE(rv_variant_transaction) TYPE abap_bool.