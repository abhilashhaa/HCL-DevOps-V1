  METHOD zif_abapgit_object~exists.

    DATA: ls_msg    TYPE hier_mess,
          ls_header TYPE ttree,
          ls_tadir  TYPE tadir.

    CALL FUNCTION 'STREE_STRUCTURE_EXIST'
      EXPORTING
        structure_id         = mv_tree_id
        do_not_read_devclass = ''
      IMPORTING
        message              = ls_msg
        structure_header     = ls_header
        structure_tadir      = ls_tadir.

    rv_bool = boolc( ls_header-id IS NOT INITIAL ).

  ENDMETHOD.