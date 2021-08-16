  PRIVATE SECTION.

    DATA mv_success TYPE abap_bool .

    TYPES: t_run_mode TYPE c LENGTH 1.
    CONSTANTS:
      BEGIN OF co_run_mode,
        run_with_popup   TYPE t_run_mode VALUE 'P',
        run_after_popup  TYPE t_run_mode VALUE 'A',
        run_via_rfc      TYPE t_run_mode VALUE 'R',
        run_in_batch     TYPE t_run_mode VALUE 'B',
        run_loc_parallel TYPE t_run_mode VALUE 'L',
        run_direct       TYPE t_run_mode VALUE 'L',
      END OF co_run_mode .
    DATA mo_inspection TYPE REF TO cl_ci_inspection .
    DATA mv_name TYPE sci_objs .
    DATA mv_run_mode TYPE c LENGTH 1 .


    METHODS create_objectset
      RETURNING
        VALUE(ro_set) TYPE REF TO cl_ci_objectset .
    METHODS run_inspection
      IMPORTING
        !io_inspection TYPE REF TO cl_ci_inspection
      RETURNING
        VALUE(rt_list) TYPE scit_alvlist
      RAISING
        zcx_abapgit_exception .
    METHODS create_inspection
      IMPORTING
        io_set               TYPE REF TO cl_ci_objectset
        io_variant           TYPE REF TO cl_ci_checkvariant
      RETURNING
        VALUE(ro_inspection) TYPE REF TO cl_ci_inspection
      RAISING
        zcx_abapgit_exception .

    METHODS decide_run_mode
      RETURNING
        VALUE(rv_run_mode) TYPE t_run_mode.