  PRIVATE SECTION.

    DATA mt_meta_fields TYPE STANDARD TABLE OF abap_compname.
    DATA mo_db TYPE REF TO zcl_abapgit_persistence_db .

    METHODS from_xml
      IMPORTING
        !iv_repo_xml_string TYPE string
      RETURNING
        VALUE(rs_repo)      TYPE zif_abapgit_persistence=>ty_repo_xml
      RAISING
        zcx_abapgit_exception .
    METHODS to_xml
      IMPORTING
        !is_repo                  TYPE zif_abapgit_persistence=>ty_repo
      RETURNING
        VALUE(rv_repo_xml_string) TYPE string .
    METHODS get_next_id
      RETURNING
        VALUE(rv_next_repo_id) TYPE zif_abapgit_persistence=>ty_content-value
      RAISING
        zcx_abapgit_exception .