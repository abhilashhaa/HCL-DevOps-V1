  METHOD zif_abapgit_object~delete.

    CONSTANTS lc_activity_delete_06 TYPE activ_auth VALUE '06'.

    TRY.
        me->zif_abapgit_object~exists( ).
      CATCH zcx_abapgit_exception.
        RETURN.
    ENDTRY.

    has_authorization( iv_structure_id = mv_tree_id
                       iv_devclass     = ms_item-devclass
                       iv_activity     = lc_activity_delete_06 ).

    is_used( mv_tree_id ).

    delete_tree_structure( mv_tree_id ).

  ENDMETHOD.