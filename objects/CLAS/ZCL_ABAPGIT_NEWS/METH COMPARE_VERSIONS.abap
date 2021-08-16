  METHOD compare_versions.

    DATA: ls_version_a TYPE zif_abapgit_definitions=>ty_version,
          ls_version_b TYPE zif_abapgit_definitions=>ty_version.

    TRY.
        ls_version_a = zcl_abapgit_version=>conv_str_to_version( iv_a ).
        ls_version_b = zcl_abapgit_version=>conv_str_to_version( iv_b ).
      CATCH zcx_abapgit_exception.
        rv_result = 0.
        RETURN.
    ENDTRY.

    IF ls_version_a = ls_version_b.
      rv_result = 0.
    ELSE.
      TRY.
          zcl_abapgit_version=>check_dependant_version( is_current   = ls_version_a
                                                        is_dependant = ls_version_b ).
          rv_result = 1.
        CATCH zcx_abapgit_exception.
          rv_result = -1.
          RETURN.
      ENDTRY.
    ENDIF.

  ENDMETHOD.