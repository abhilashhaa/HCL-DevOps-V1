  PROTECTED SECTION.
    TYPES: ty_char32 TYPE c LENGTH 32.

    CLASS-DATA gv_max_threads TYPE i .
    DATA mt_files TYPE zif_abapgit_definitions=>ty_files_item_tt .
    DATA mv_free TYPE i .
    DATA mi_log TYPE REF TO zif_abapgit_log .
    DATA mv_group TYPE rzlli_apcl .
    DATA mv_serialize_master_lang_only TYPE abap_bool.

    METHODS add_to_return
      IMPORTING
        !iv_path      TYPE string
        !is_fils_item TYPE zcl_abapgit_objects=>ty_serialization .
    METHODS run_parallel
      IMPORTING
        !is_tadir    TYPE zif_abapgit_definitions=>ty_tadir
        !iv_language TYPE langu
        !iv_task     TYPE ty_char32
      RAISING
        zcx_abapgit_exception .
    METHODS run_sequential
      IMPORTING
        !is_tadir    TYPE zif_abapgit_definitions=>ty_tadir
        !iv_language TYPE langu
      RAISING
        zcx_abapgit_exception .
    METHODS determine_max_threads
      IMPORTING
        !iv_force_sequential TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rv_threads)    TYPE i
      RAISING
        zcx_abapgit_exception .