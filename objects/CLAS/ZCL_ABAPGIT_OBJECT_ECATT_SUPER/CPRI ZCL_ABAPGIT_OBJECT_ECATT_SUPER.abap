  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_last_changed,
        luser TYPE xubname,
        ldate TYPE d,
        ltime TYPE t,
      END OF ty_last_changed.

    CONSTANTS:
      BEGIN OF co_name,
        version  TYPE string VALUE 'VERSION' ##NO_TEXT,
        versions TYPE string VALUE 'VERSIONS' ##NO_TEXT,
      END OF co_name,
      co_default_version TYPE etobj_ver VALUE '1' ##NO_TEXT.

    CLASS-METHODS:
      is_change_more_recent_than
        IMPORTING
          is_currently_changed            TYPE ty_last_changed
          is_last_changed                 TYPE ty_last_changed
        RETURNING
          VALUE(rv_is_change_more_recent) TYPE abap_bool.

    DATA:
      mv_object_name TYPE etobj_name.

    METHODS:
      get_changed_date
        IMPORTING
          ii_document            TYPE REF TO if_ixml_document
        RETURNING
          VALUE(rv_changed_date) TYPE d,

      get_changed_time
        IMPORTING
          ii_document            TYPE REF TO if_ixml_document
        RETURNING
          VALUE(rv_changed_time) TYPE t,

      get_changed_by_user
        IMPORTING
          ii_document               TYPE REF TO if_ixml_document
        RETURNING
          VALUE(rv_changed_by_user) TYPE xubname,

      get_change_information
        IMPORTING
          is_version_info              TYPE etversinfo
        RETURNING
          VALUE(rs_change_information) TYPE ty_last_changed
        RAISING
          cx_ecatt_apl
          zcx_abapgit_exception,

      clear_attributes
        CHANGING
          ci_document TYPE REF TO if_ixml_document,

      clear_elements
        CHANGING
          ci_document TYPE REF TO if_ixml_document,

      get_version_from_node
        IMPORTING
          ii_node           TYPE REF TO if_ixml_node
        RETURNING
          VALUE(rv_version) TYPE string,

      deserialize_version
        IMPORTING
          ii_version_node TYPE REF TO if_ixml_node
          iv_package      TYPE devclass
        RAISING
          zcx_abapgit_exception,

      serialize_version
        IMPORTING
          iv_version TYPE etversinfo-version
        CHANGING
          ci_node    TYPE REF TO if_ixml_element
        RAISING
          cx_ecatt
          zcx_abapgit_exception,

      clear_element
        IMPORTING
          iv_name     TYPE csequence
        CHANGING
          ci_document TYPE REF TO if_ixml_document,

      serialize_versions
        IMPORTING
          it_version_info TYPE etversinfo_tabtype
        CHANGING
          ci_document     TYPE REF TO if_ixml_document
        RAISING
          cx_ecatt
          zcx_abapgit_exception.