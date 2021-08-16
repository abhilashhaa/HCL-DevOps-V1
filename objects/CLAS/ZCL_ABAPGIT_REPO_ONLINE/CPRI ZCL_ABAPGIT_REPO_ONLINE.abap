  PRIVATE SECTION.

    DATA mt_objects TYPE zif_abapgit_definitions=>ty_objects_tt .
    DATA mv_branch TYPE zif_abapgit_definitions=>ty_sha1 .

    METHODS handle_stage_ignore
      IMPORTING
        !io_stage TYPE REF TO zcl_abapgit_stage
      RAISING
        zcx_abapgit_exception .
    METHODS set_objects
      IMPORTING
        !it_objects TYPE zif_abapgit_definitions=>ty_objects_tt
      RAISING
        zcx_abapgit_exception .
    METHODS fetch_remote
      RAISING
        zcx_abapgit_exception .