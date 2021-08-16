  METHOD zif_abapgit_object~exists.

    TRY.
        read( ).
        rv_bool = abap_true.
      CATCH zcx_abapgit_not_found
            zcx_abapgit_exception.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.