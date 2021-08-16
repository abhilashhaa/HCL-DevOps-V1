  PRIVATE SECTION.

    DATA:
      mt_components TYPE TABLE OF wdy_ctlr_compo_vrs,
      mt_sources    TYPE TABLE OF wdy_ctlr_compo_source_vrs.

    METHODS:
      get_limu_objects
        RETURNING VALUE(rt_objects) TYPE wdy_md_transport_keys,
      read
        RETURNING VALUE(rs_component) TYPE wdy_component_metadata
        RAISING   zcx_abapgit_exception,
      read_controller
        IMPORTING is_key               TYPE wdy_md_controller_key
        RETURNING VALUE(rs_controller) TYPE wdy_md_controller_meta_data
        RAISING   zcx_abapgit_exception,
      read_definition
        IMPORTING is_key               TYPE wdy_md_component_key
        RETURNING VALUE(rs_definition) TYPE wdy_md_component_meta_data
        RAISING   zcx_abapgit_exception,
      read_view
        IMPORTING is_key         TYPE wdy_md_view_key
        RETURNING VALUE(rs_view) TYPE wdy_md_view_meta_data
        RAISING   zcx_abapgit_exception,
      recover_controller
        IMPORTING is_controller TYPE wdy_md_controller_meta_data
        RAISING   zcx_abapgit_exception,
      recover_definition
        IMPORTING is_definition TYPE wdy_md_component_meta_data
                  iv_package    TYPE devclass
        RAISING   zcx_abapgit_exception,
      recover_view
        IMPORTING is_view TYPE wdy_md_view_meta_data
        RAISING   zcx_abapgit_exception,
      delta_controller
        IMPORTING is_controller   TYPE wdy_md_controller_meta_data
        RETURNING VALUE(rs_delta) TYPE svrs2_xversionable_object
        RAISING   zcx_abapgit_exception,
      delta_definition
        IMPORTING is_definition     TYPE wdy_md_component_meta_data
                  VALUE(iv_package) TYPE devclass
        RETURNING VALUE(rs_delta)   TYPE svrs2_xversionable_object
        RAISING   zcx_abapgit_exception,
      delta_view
        IMPORTING is_view         TYPE wdy_md_view_meta_data
        RETURNING VALUE(rs_delta) TYPE svrs2_xversionable_object
        RAISING   zcx_abapgit_exception,
      add_fm_param_exporting
        IMPORTING iv_name  TYPE string
                  ig_value TYPE any
        CHANGING  ct_param TYPE abap_func_parmbind_tab,
      add_fm_param_tables
        IMPORTING iv_name  TYPE string
        CHANGING  ct_value TYPE ANY TABLE
                  ct_param TYPE abap_func_parmbind_tab,
      add_fm_exception
        IMPORTING iv_name      TYPE string
                  iv_value     TYPE i
        CHANGING  ct_exception TYPE abap_func_excpbind_tab.
