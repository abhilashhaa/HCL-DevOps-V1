"! Performance test run
CLASS zcl_abapgit_performance_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF gty_result,
        pgmid    TYPE pgmid,
        object   TYPE trobjtype,
        obj_name TYPE sobj_name,
        devclass TYPE devclass,
        counter  TYPE i,
        runtime  TYPE i,
        seconds  TYPE p LENGTH 16 DECIMALS 6,
      END OF gty_result,
      gty_result_tab TYPE STANDARD TABLE OF gty_result WITH KEY pgmid object obj_name.
    METHODS:
      constructor IMPORTING iv_package                    TYPE devclass
                            iv_include_sub_packages       TYPE abap_bool DEFAULT abap_true
                            iv_serialize_master_lang_only TYPE abap_bool DEFAULT abap_true,
      set_object_type_filter IMPORTING it_object_type_range TYPE zif_abapgit_definitions=>ty_object_type_range,
      set_object_name_filter IMPORTING it_object_name_range TYPE zif_abapgit_definitions=>ty_object_name_range,
      get_object_type_filter RETURNING VALUE(rt_object_type_range) TYPE zif_abapgit_definitions=>ty_object_type_range,
      get_object_name_filter RETURNING VALUE(rt_object_name_range) TYPE zif_abapgit_definitions=>ty_object_name_range,
      run_measurement RAISING zcx_abapgit_exception,
      get_result RETURNING VALUE(rt_result) TYPE gty_result_tab.