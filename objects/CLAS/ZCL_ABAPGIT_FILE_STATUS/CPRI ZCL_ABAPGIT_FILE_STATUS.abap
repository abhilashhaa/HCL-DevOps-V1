  PRIVATE SECTION.

    CLASS-METHODS:
      calculate_status
        IMPORTING iv_devclass       TYPE devclass
                  io_dot            TYPE REF TO zcl_abapgit_dot_abapgit
                  it_local          TYPE zif_abapgit_definitions=>ty_files_item_tt
                  it_remote         TYPE zif_abapgit_definitions=>ty_files_tt
                  it_cur_state      TYPE zif_abapgit_definitions=>ty_file_signatures_tt
        RETURNING VALUE(rt_results) TYPE zif_abapgit_definitions=>ty_results_tt
        RAISING   zcx_abapgit_exception,
      run_checks
        IMPORTING ii_log     TYPE REF TO zif_abapgit_log
                  it_results TYPE zif_abapgit_definitions=>ty_results_tt
                  io_dot     TYPE REF TO zcl_abapgit_dot_abapgit
                  iv_top     TYPE devclass
        RAISING   zcx_abapgit_exception,
      build_existing
        IMPORTING is_local         TYPE zif_abapgit_definitions=>ty_file_item
                  is_remote        TYPE zif_abapgit_definitions=>ty_file
                  it_state         TYPE zif_abapgit_definitions=>ty_file_signatures_ts
        RETURNING VALUE(rs_result) TYPE zif_abapgit_definitions=>ty_result,
      build_new_local
        IMPORTING is_local         TYPE zif_abapgit_definitions=>ty_file_item
        RETURNING VALUE(rs_result) TYPE zif_abapgit_definitions=>ty_result,
      build_new_remote
        IMPORTING iv_devclass      TYPE devclass
                  io_dot           TYPE REF TO zcl_abapgit_dot_abapgit
                  is_remote        TYPE zif_abapgit_definitions=>ty_file
                  it_items         TYPE zif_abapgit_definitions=>ty_items_ts
                  it_state         TYPE zif_abapgit_definitions=>ty_file_signatures_ts
        RETURNING VALUE(rs_result) TYPE zif_abapgit_definitions=>ty_result
        RAISING   zcx_abapgit_exception,
      identify_object
        IMPORTING iv_filename TYPE string
                  iv_path     TYPE string
                  iv_devclass TYPE devclass
                  io_dot      TYPE REF TO zcl_abapgit_dot_abapgit
        EXPORTING es_item     TYPE zif_abapgit_definitions=>ty_item
                  ev_is_xml   TYPE abap_bool
        RAISING   zcx_abapgit_exception,
      get_object_package
        IMPORTING
          iv_object          TYPE tadir-object
          iv_obj_name        TYPE tadir-obj_name
        RETURNING
          VALUE(rv_devclass) TYPE devclass
        RAISING
          zcx_abapgit_exception .
