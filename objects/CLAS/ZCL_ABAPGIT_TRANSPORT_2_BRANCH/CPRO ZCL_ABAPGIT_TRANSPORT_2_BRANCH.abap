  PROTECTED SECTION.

    METHODS generate_commit_message
      IMPORTING
        !is_transport_to_branch TYPE zif_abapgit_definitions=>ty_transport_to_branch
      RETURNING
        VALUE(rs_comment)       TYPE zif_abapgit_definitions=>ty_comment .
    METHODS stage_transport_objects
      IMPORTING
        !it_transport_objects TYPE zif_abapgit_definitions=>ty_tadir_tt
        !io_stage             TYPE REF TO zcl_abapgit_stage
        !is_stage_objects     TYPE zif_abapgit_definitions=>ty_stage_files
        !it_object_statuses   TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING
        zcx_abapgit_exception .