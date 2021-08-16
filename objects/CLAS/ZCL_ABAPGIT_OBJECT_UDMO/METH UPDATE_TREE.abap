  METHOD update_tree.

    CALL FUNCTION 'RS_TREE_OBJECT_PLACEMENT'
      EXPORTING
        object    = me->mv_data_model
        operation = 'INSERT'
        type      = me->c_correction_object_type.

  ENDMETHOD.