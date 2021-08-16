  PRIVATE SECTION.
    DATA: mv_tree_id TYPE ttree-id.

    METHODS jump_se43
      RAISING zcx_abapgit_exception.

    METHODS clear_fields
      CHANGING cs_head  TYPE ttree
               ct_nodes TYPE hier_iface_t.
