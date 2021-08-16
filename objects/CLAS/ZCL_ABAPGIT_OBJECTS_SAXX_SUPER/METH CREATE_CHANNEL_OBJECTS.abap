  METHOD create_channel_objects.

    get_names( ).

    TRY.
        IF mi_appl_obj_data IS NOT BOUND.
          CREATE OBJECT mi_appl_obj_data TYPE (mv_appl_obj_cls_name).
        ENDIF.

        IF mi_persistence IS NOT BOUND.
          CREATE OBJECT mi_persistence TYPE (mv_persistence_cls_name).
        ENDIF.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |{ ms_item-obj_type } not supported| ).
    ENDTRY.

  ENDMETHOD.