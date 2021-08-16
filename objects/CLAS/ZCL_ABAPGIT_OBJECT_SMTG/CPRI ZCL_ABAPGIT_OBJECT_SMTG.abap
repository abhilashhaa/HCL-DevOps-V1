  PRIVATE SECTION.
    DATA:
      mv_template_id TYPE c LENGTH 30,
      mo_structdescr TYPE REF TO cl_abap_structdescr.

    METHODS:
      clear_field
        IMPORTING
          iv_fieldname TYPE string
        CHANGING
          cg_header    TYPE any,

      get_structure
        RETURNING
          VALUE(ro_structdescr) TYPE REF TO cl_abap_structdescr
        RAISING
          zcx_abapgit_exception,

      add_component
        IMPORTING
          iv_fielname       TYPE string
          iv_structure_name TYPE string
        CHANGING
          ct_components     TYPE abap_component_tab
        RAISING
          zcx_abapgit_exception.