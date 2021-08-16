  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_obj_serializer_map,
        item     TYPE zif_abapgit_definitions=>ty_item,
        metadata TYPE zif_abapgit_definitions=>ty_metadata,
      END OF ty_obj_serializer_map .
    TYPES:
      tty_obj_serializer_map
            TYPE SORTED TABLE OF ty_obj_serializer_map WITH UNIQUE KEY item .

    CLASS-DATA gt_obj_serializer_map TYPE tty_obj_serializer_map .

    CLASS-METHODS files_to_deserialize
      IMPORTING
        !io_repo          TYPE REF TO zcl_abapgit_repo
        !ii_log           TYPE REF TO zif_abapgit_log OPTIONAL
      RETURNING
        VALUE(rt_results) TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS check_duplicates
      IMPORTING
        !it_files TYPE zif_abapgit_definitions=>ty_files_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS prioritize_deser
      IMPORTING
        !it_results       TYPE zif_abapgit_definitions=>ty_results_tt
      RETURNING
        VALUE(rt_results) TYPE zif_abapgit_definitions=>ty_results_tt .
    CLASS-METHODS class_name
      IMPORTING
        !is_item             TYPE zif_abapgit_definitions=>ty_item
      RETURNING
        VALUE(rv_class_name) TYPE string .
    CLASS-METHODS warning_overwrite_adjust
      IMPORTING
        !it_overwrite TYPE zif_abapgit_definitions=>ty_overwrite_tt
      CHANGING
        !ct_results   TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS checks_adjust
      IMPORTING
        !io_repo    TYPE REF TO zcl_abapgit_repo
        !is_checks  TYPE zif_abapgit_definitions=>ty_deserialize_checks
      CHANGING
        !ct_results TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS warning_overwrite_find
      IMPORTING
        !it_results         TYPE zif_abapgit_definitions=>ty_results_tt
      RETURNING
        VALUE(rt_overwrite) TYPE zif_abapgit_definitions=>ty_overwrite_tt .
    CLASS-METHODS warning_package_adjust
      IMPORTING
        !io_repo      TYPE REF TO zcl_abapgit_repo
        !it_overwrite TYPE zif_abapgit_definitions=>ty_overwrite_tt
      CHANGING
        !ct_results   TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS warning_package_find
      IMPORTING
        !it_results         TYPE zif_abapgit_definitions=>ty_results_tt
        !io_repo            TYPE REF TO zcl_abapgit_repo
      RETURNING
        VALUE(rt_overwrite) TYPE zif_abapgit_definitions=>ty_overwrite_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS update_package_tree
      IMPORTING
        !iv_package TYPE devclass .
    CLASS-METHODS delete_obj
      IMPORTING
        !iv_package TYPE devclass
        !is_item    TYPE zif_abapgit_definitions=>ty_item
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS compare_remote_to_local
      IMPORTING
        !ii_object TYPE REF TO zif_abapgit_object
        !it_remote TYPE zif_abapgit_definitions=>ty_files_tt
        !is_result TYPE zif_abapgit_definitions=>ty_result
        !ii_log    TYPE REF TO zif_abapgit_log
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS deserialize_objects
      IMPORTING
        !is_step  TYPE zif_abapgit_definitions=>ty_step_data
        !ii_log   TYPE REF TO zif_abapgit_log
      CHANGING
        !ct_files TYPE zif_abapgit_definitions=>ty_file_signatures_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS check_objects_locked
      IMPORTING
        !iv_language TYPE spras
        !it_items    TYPE zif_abapgit_definitions=>ty_items_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS create_object
      IMPORTING
        !is_item        TYPE zif_abapgit_definitions=>ty_item
        !iv_language    TYPE spras
        !is_metadata    TYPE zif_abapgit_definitions=>ty_metadata OPTIONAL
        !iv_native_only TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(ri_obj)   TYPE REF TO zif_abapgit_object
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS map_tadir_to_items
      IMPORTING
        !it_tadir       TYPE zif_abapgit_definitions=>ty_tadir_tt
      RETURNING
        VALUE(rt_items) TYPE zif_abapgit_definitions=>ty_items_tt .
    CLASS-METHODS map_results_to_items
      IMPORTING
        !it_results     TYPE zif_abapgit_definitions=>ty_results_tt
      RETURNING
        VALUE(rt_items) TYPE zif_abapgit_definitions=>ty_items_tt .
    CLASS-METHODS filter_files_to_deserialize
      IMPORTING
        !it_results       TYPE zif_abapgit_definitions=>ty_results_tt
        !ii_log           TYPE REF TO zif_abapgit_log OPTIONAL
      RETURNING
        VALUE(rt_results) TYPE zif_abapgit_definitions=>ty_results_tt .
    CLASS-METHODS adjust_namespaces
      IMPORTING
        !it_results       TYPE zif_abapgit_definitions=>ty_results_tt
      RETURNING
        VALUE(rt_results) TYPE zif_abapgit_definitions=>ty_results_tt .
    CLASS-METHODS get_deserialize_steps
      RETURNING
        VALUE(rt_steps) TYPE zif_abapgit_definitions=>ty_step_data_tt .