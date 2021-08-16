  PROTECTED SECTION.

    METHODS has_authorization
      IMPORTING
        !iv_devclass     TYPE devclass
        !iv_structure_id TYPE hier_guid
        !iv_activity     TYPE activ_auth
      RAISING
        zcx_abapgit_exception .
    METHODS is_used
      IMPORTING
        !iv_structure_id TYPE hier_guid
      RAISING
        zcx_abapgit_exception .
    METHODS delete_tree_structure
      IMPORTING
        !iv_structure_id TYPE hier_guid .