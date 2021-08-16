  METHOD is_active.

    DATA: li_object TYPE REF TO zif_abapgit_object.

    TRY.
        li_object = create_object( is_item     = is_item
                                   iv_language = sy-langu ).

        rv_active = li_object->is_active( ).
      CATCH cx_sy_dyn_call_illegal_method
            cx_sy_ref_is_initial
            zcx_abapgit_exception.
        rv_active = abap_true.
    ENDTRY.
  ENDMETHOD.