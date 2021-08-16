  PROTECTED SECTION.
    TYPES: BEGIN OF ty_commit_value_tab,
             sha1     TYPE zif_abapgit_definitions=>ty_sha1,
             message  TYPE c LENGTH 50,
             datetime TYPE c LENGTH 20,
           END OF ty_commit_value_tab.
    TYPES: ty_commit_value_tab_tt TYPE STANDARD TABLE OF ty_commit_value_tab WITH DEFAULT KEY .

    CLASS-METHODS get_unnecessary_local_objs
      IMPORTING
        !io_repo                            TYPE REF TO zcl_abapgit_repo
      RETURNING
        VALUE(rt_unnecessary_local_objects) TYPE zif_abapgit_definitions=>ty_tadir_tt
      RAISING
        zcx_abapgit_exception .