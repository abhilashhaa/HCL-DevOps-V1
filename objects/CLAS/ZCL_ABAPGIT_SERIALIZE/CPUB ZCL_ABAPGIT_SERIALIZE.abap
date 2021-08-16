CLASS zcl_abapgit_serialize DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_serialize_master_lang_only TYPE abap_bool DEFAULT abap_false.
    METHODS on_end_of_task
      IMPORTING
        !p_task TYPE clike .
    METHODS serialize
      IMPORTING
        it_tadir            TYPE zif_abapgit_definitions=>ty_tadir_tt
        iv_language         TYPE langu DEFAULT sy-langu
        ii_log              TYPE REF TO zif_abapgit_log OPTIONAL
        iv_force_sequential TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rt_files)     TYPE zif_abapgit_definitions=>ty_files_item_tt
      RAISING
        zcx_abapgit_exception .
