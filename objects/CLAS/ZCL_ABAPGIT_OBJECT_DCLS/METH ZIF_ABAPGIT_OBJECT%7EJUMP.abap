  METHOD zif_abapgit_object~jump.

    TRY.

        jump_adt( iv_obj_name = ms_item-obj_name
                  iv_obj_type = ms_item-obj_type ).

      CATCH zcx_abapgit_exception.
        zcx_abapgit_exception=>raise( 'DCLS Jump Error' ).
    ENDTRY.

  ENDMETHOD.