  METHOD zif_abapgit_object~changed_by.

    DATA: ls_head TYPE ttree.

    CALL FUNCTION 'STREE_STRUCTURE_READ'
      EXPORTING
        structure_id     = mv_tree_id
      IMPORTING
        structure_header = ls_head.

    rv_user = ls_head-luser.

  ENDMETHOD.