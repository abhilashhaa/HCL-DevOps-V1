  PRIVATE SECTION.

    DATA mi_listener TYPE REF TO zif_abapgit_repo_listener .
    DATA mo_apack_reader TYPE REF TO zcl_abapgit_apack_reader .

    METHODS get_local_checksums
      RETURNING
        VALUE(rt_checksums) TYPE zif_abapgit_persistence=>ty_local_checksum_tt .
    METHODS notify_listener
      IMPORTING
        !is_change_mask TYPE zif_abapgit_persistence=>ty_repo_meta_mask
      RAISING
        zcx_abapgit_exception .
    METHODS build_dotabapgit_file
      RETURNING
        VALUE(rs_file) TYPE zif_abapgit_definitions=>ty_file
      RAISING
        zcx_abapgit_exception .
    METHODS build_apack_manifest_file
      RETURNING
        VALUE(rs_file) TYPE zif_abapgit_definitions=>ty_file
      RAISING
        zcx_abapgit_exception .
    METHODS update_last_deserialize
      RAISING
        zcx_abapgit_exception .
    METHODS check_for_restart .
    METHODS check_write_protect
      RAISING
        zcx_abapgit_exception .
    METHODS check_language
      RAISING
        zcx_abapgit_exception .