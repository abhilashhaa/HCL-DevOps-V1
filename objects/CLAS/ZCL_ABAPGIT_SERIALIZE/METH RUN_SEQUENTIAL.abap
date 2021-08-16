  METHOD run_sequential.

    DATA: lx_error     TYPE REF TO zcx_abapgit_exception,
          ls_fils_item TYPE zcl_abapgit_objects=>ty_serialization.


    ls_fils_item-item-obj_type = is_tadir-object.
    ls_fils_item-item-obj_name = is_tadir-obj_name.
    ls_fils_item-item-devclass = is_tadir-devclass.

    TRY.
        ls_fils_item = zcl_abapgit_objects=>serialize(
          is_item     = ls_fils_item-item
          iv_serialize_master_lang_only = mv_serialize_master_lang_only
          iv_language = iv_language ).

        add_to_return( is_fils_item = ls_fils_item
                       iv_path      = is_tadir-path ).
      CATCH zcx_abapgit_exception INTO lx_error.
        IF NOT mi_log IS INITIAL.
          mi_log->add_exception(
              ix_exc  = lx_error
              is_item = ls_fils_item-item ).
        ENDIF.
    ENDTRY.

  ENDMETHOD.