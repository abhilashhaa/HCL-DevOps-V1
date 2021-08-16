  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_s_objkey,
        num   TYPE n LENGTH 3,
        value TYPE c LENGTH 128,
      END OF ty_s_objkey .
    TYPES:
      ty_t_objkey TYPE SORTED TABLE OF ty_s_objkey WITH UNIQUE KEY num .

    DATA ms_object_header TYPE objh .
    DATA:
      mt_object_table                TYPE STANDARD TABLE OF objsl WITH DEFAULT KEY .
    DATA:
      mt_object_method               TYPE STANDARD TABLE OF objm WITH DEFAULT KEY .
    DATA ms_item TYPE zif_abapgit_definitions=>ty_item .

    METHODS after_import .
    METHODS before_export .
    METHODS corr_insert
      IMPORTING
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_data
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS distribute_name_to_components
      IMPORTING
        !it_key_component TYPE ddfields
      CHANGING
        !ct_objkey        TYPE ty_t_objkey
        !cs_objkey        TYPE ty_s_objkey
        !cv_non_value_pos TYPE numc3 .
    METHODS get_key_fields
      IMPORTING
        !iv_table      TYPE objsl-tobj_name
      RETURNING
        VALUE(rt_keys) TYPE ddfields
      RAISING
        zcx_abapgit_exception .
    METHODS get_primary_table
      RETURNING
        VALUE(rv_table) TYPE objsl-tobj_name
      RAISING
        zcx_abapgit_exception .
    METHODS get_where_clause
      IMPORTING
        !iv_tobj_name   TYPE objsl-tobj_name
      RETURNING
        VALUE(rv_where) TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS serialize_data
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_output
      RAISING
        zcx_abapgit_exception .
    METHODS split_value_to_keys
      IMPORTING
        !it_key_component TYPE ddfields
      CHANGING
        !ct_objkey        TYPE ty_t_objkey
        !cs_objkey        TYPE ty_s_objkey
        !cv_non_value_pos TYPE numc3 .
    METHODS validate
      IMPORTING
        !io_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .