  PRIVATE SECTION.
    DATA: mo_db   TYPE REF TO zcl_abapgit_persistence_db,
          mt_jobs TYPE tt_background.

    METHODS from_xml
      IMPORTING iv_string     TYPE string
      RETURNING VALUE(rs_xml) TYPE ty_xml
      RAISING   zcx_abapgit_exception.

    METHODS to_xml
      IMPORTING is_background    TYPE ty_background
      RETURNING VALUE(rv_string) TYPE string.
