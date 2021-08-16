  PRIVATE SECTION.
    " Downport original structures from
    "   - IF_DBPROC_PROXY_UI
    "   - IF_DBPROC_PROXY_BASIC_TYPES

    TYPES:
      ty_db_name         TYPE c LENGTH 256,
      ty_abap_name       TYPE c LENGTH 30,
      ty_param_direction TYPE c LENGTH 10,
      ty_param_kind      TYPE c LENGTH 10,
      ty_ddic_name       TYPE ddobjname,

      BEGIN OF ty_db_simple_type_s,
        name   TYPE ty_db_name,
        length TYPE i,
        decs   TYPE i,
      END OF ty_db_simple_type_s,

      BEGIN OF ty_abap_simple_type_s,
        name   TYPE ty_abap_name,
        length TYPE i,
        decs   TYPE i,
      END OF ty_abap_simple_type_s,

      BEGIN OF ty_abap_simple_type_ui_s,
        typ  TYPE ty_abap_simple_type_s,
        text TYPE string,
      END OF ty_abap_simple_type_ui_s,

      BEGIN OF ty_header_ui_s,
        db_repository_package   TYPE ty_db_name,
        db_repository_proc_name TYPE ty_db_name,
        db_catalog_schema       TYPE ty_db_name,
        db_catalog_proc_name    TYPE ty_db_name,
        read_only               TYPE abap_bool,
        interface_pool          TYPE ty_abap_name,
      END OF  ty_header_ui_s,

      BEGIN OF ty_param_ui_s,
        position              TYPE i,
        db_name               TYPE ty_db_name,
        direction             TYPE ty_param_direction,
        kind                  TYPE ty_param_kind,
        db_table_type_schema  TYPE ty_db_name,
        db_table_type_name    TYPE ty_db_name,
        db_table_type_is_ddic TYPE abap_bool,
        transfer_table_schema TYPE ty_db_name,
        transfer_table_name   TYPE ty_db_name,
        abap_name             TYPE ty_abap_name,
        abap_name_is_ro       TYPE abap_bool,
        ddic_table            TYPE ty_ddic_name,
        ddic_table_is_ro      TYPE abap_bool,
      END OF  ty_param_ui_s,
      ty_param_ui_t            TYPE STANDARD TABLE OF ty_param_ui_s WITH KEY position,

      ty_abap_simple_type_ui_t TYPE STANDARD TABLE OF ty_abap_simple_type_ui_s WITH DEFAULT KEY,

      BEGIN OF ty_param_type_ui_s,
        param_position       TYPE i,
        comp_index           TYPE i,
        db_comp_name         TYPE ty_db_name,
        abap_comp_name       TYPE ty_abap_name,
        abap_comp_name_is_ro TYPE abap_bool,
        db_type              TYPE ty_db_simple_type_s,
        db_type_text         TYPE string,
        abap_type            TYPE ty_abap_simple_type_ui_s,
        abap_type_is_ro      TYPE abap_bool,
        abap_type_selection  TYPE ty_abap_simple_type_ui_t,
        ddic_type            TYPE ty_ddic_name,
        ddic_type_is_ro      TYPE abap_bool,
      END OF ty_param_type_ui_s ,
      ty_param_type_ui_t TYPE STANDARD TABLE OF ty_param_type_ui_s WITH KEY param_position comp_index,

      BEGIN OF ty_proxy,
        description     TYPE ddtext,
        header          TYPE ty_header_ui_s,
        parameters      TYPE ty_param_ui_t,
        parameter_types TYPE ty_param_type_ui_t,
      END OF ty_proxy.

    DATA:
      mo_proxy     TYPE REF TO object,
      mv_transport TYPE e070use-ordernum.

    METHODS:
      delete_interface_if_it_exists
        IMPORTING
          iv_package   TYPE devclass
          iv_interface TYPE ty_abap_name
        RAISING
          zcx_abapgit_exception.
