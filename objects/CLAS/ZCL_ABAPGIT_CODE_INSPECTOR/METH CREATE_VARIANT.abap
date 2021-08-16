  METHOD create_variant.

    IF iv_variant IS INITIAL.
      zcx_abapgit_exception=>raise( |No check variant supplied.| ).
    ENDIF.

    cl_ci_checkvariant=>get_ref(
      EXPORTING
        p_user                   = ''
        p_name                   = iv_variant
      RECEIVING
        p_ref                    = ro_variant
      EXCEPTIONS
        chkv_not_exists          = 1
        missing_parameter        = 2
        OTHERS                   = 3 ).

    CASE sy-subrc.
      WHEN 1.
        zcx_abapgit_exception=>raise( |Check variant { iv_variant } doesn't exist| ).
      WHEN 2.
        zcx_abapgit_exception=>raise( |Parameter missing for check variant { iv_variant }| ).
    ENDCASE.

  ENDMETHOD.