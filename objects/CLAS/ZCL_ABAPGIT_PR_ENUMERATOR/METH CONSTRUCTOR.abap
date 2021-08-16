  METHOD constructor.

    DATA lo_repo_online TYPE REF TO zcl_abapgit_repo_online.

    IF io_repo IS NOT BOUND OR io_repo->is_offline( ) = abap_true.
      RETURN.
    ENDIF.

    lo_repo_online ?= io_repo.
    mv_repo_url     = to_lower( lo_repo_online->get_url( ) ).
    TRY.
        mi_enum_provider = create_provider( mv_repo_url ).
      CATCH zcx_abapgit_exception.
    ENDTRY.

  ENDMETHOD.