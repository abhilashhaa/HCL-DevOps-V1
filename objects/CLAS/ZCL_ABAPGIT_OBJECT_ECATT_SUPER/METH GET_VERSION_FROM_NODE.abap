  METHOD get_version_from_node.

    TRY.
        rv_version = ii_node->get_first_child(
                           )->get_first_child(
                           )->get_first_child(
                           )->get_first_child(
                           )->get_value( ).

      CATCH cx_sy_ref_is_initial.
        RETURN.
    ENDTRY.

  ENDMETHOD.