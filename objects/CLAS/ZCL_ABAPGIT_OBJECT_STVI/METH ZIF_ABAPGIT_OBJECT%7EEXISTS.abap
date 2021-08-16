  METHOD zif_abapgit_object~exists.

    DATA: lv_transaction_variant TYPE tcvariant.

    lv_transaction_variant = ms_item-obj_name.

    CALL FUNCTION 'RS_HDSYS_EXIST_CHECK_VARIANT'
      EXPORTING
        tcvariant                 = lv_transaction_variant
        i_flag_client_independent = abap_true
      EXCEPTIONS
        no_variant                = 1
        OTHERS                    = 2.
    IF sy-subrc = 0.
      rv_bool = abap_true.
    ENDIF.

  ENDMETHOD.