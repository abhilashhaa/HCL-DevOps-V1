  PROTECTED SECTION.

    DATA ms_item TYPE zif_abapgit_definitions=>ty_item .
    DATA mv_language TYPE spras .

    METHODS check_timestamp
      IMPORTING
        !iv_timestamp     TYPE timestamp
        !iv_date          TYPE d
        !iv_time          TYPE t
      RETURNING
        VALUE(rv_changed) TYPE abap_bool .
    METHODS get_metadata
      RETURNING
        VALUE(rs_metadata) TYPE zif_abapgit_definitions=>ty_metadata .
    METHODS corr_insert
      IMPORTING
        !iv_package      TYPE devclass
        !ig_object_class TYPE any OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS tadir_insert
      IMPORTING
        !iv_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    METHODS jump_se11
      IMPORTING
        !iv_radio TYPE string
        !iv_field TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS exists_a_lock_entry_for
      IMPORTING
        !iv_lock_object               TYPE string
        !iv_argument                  TYPE seqg3-garg OPTIONAL
      RETURNING
        VALUE(rv_exists_a_lock_entry) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS set_default_package
      IMPORTING
        !iv_package TYPE devclass .
    METHODS serialize_longtexts
      IMPORTING
        !ii_xml         TYPE REF TO zif_abapgit_xml_output
        !iv_longtext_id TYPE dokil-id OPTIONAL
        !it_dokil       TYPE zif_abapgit_definitions=>tty_dokil OPTIONAL
      RAISING
        zcx_abapgit_exception .
    METHODS deserialize_longtexts
      IMPORTING
        !ii_xml TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .
    METHODS delete_longtexts
      IMPORTING
        !iv_longtext_id TYPE dokil-id
      RAISING
        zcx_abapgit_exception .
    METHODS is_active
      RETURNING
        VALUE(rv_active) TYPE abap_bool
      RAISING
        zcx_abapgit_exception .
    METHODS delete_ddic
      IMPORTING
        VALUE(iv_objtype)              TYPE string
        VALUE(iv_no_ask)               TYPE abap_bool DEFAULT abap_true
        VALUE(iv_no_ask_delete_append) TYPE abap_bool DEFAULT abap_false
      RAISING
        zcx_abapgit_exception .