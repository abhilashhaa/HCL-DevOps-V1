  METHOD zif_abapgit_object~jump.

    DATA: ls_head TYPE ttree.

    CALL FUNCTION 'STREE_STRUCTURE_READ'
      EXPORTING
        structure_id     = mv_tree_id
      IMPORTING
        structure_header = ls_head.

    CASE ls_head-type.
      WHEN 'BMENU'.
        jump_se43( ).
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |Jump for type { ls_head-type } not implemented| ).
    ENDCASE.

  ENDMETHOD.