CLASS zcl_abapgit_branch_overview DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_abapgit_factory .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_branch_overview .
    CONSTANTS c_deleted_branch_name_prefix TYPE string VALUE '__DELETED_BRANCH_' ##NO_TEXT.

    METHODS constructor
      IMPORTING
        io_repo TYPE REF TO zcl_abapgit_repo_online
      RAISING
        zcx_abapgit_exception .
