  METHOD validate_check_variant.

    cl_ci_checkvariant=>get_ref(
      EXPORTING
        p_user                   = ''
        p_name                   = iv_check_variant_name
      EXCEPTIONS
        chkv_not_exists          = 1
        missing_parameter        = 2
        OTHERS                   = 3 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |No valid check variant { iv_check_variant_name  }| ).
    ENDIF.

  ENDMETHOD.