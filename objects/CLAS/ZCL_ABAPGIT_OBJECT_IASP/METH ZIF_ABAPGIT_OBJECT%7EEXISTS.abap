  METHOD zif_abapgit_object~exists.

    DATA: lx_error TYPE REF TO zcx_abapgit_exception.

    TRY.
        w3_api_load( ).
        rv_bool = abap_true.

      CATCH zcx_abapgit_exception INTO lx_error.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.