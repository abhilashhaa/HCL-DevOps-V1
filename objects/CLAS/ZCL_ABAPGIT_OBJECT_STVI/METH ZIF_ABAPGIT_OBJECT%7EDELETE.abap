  METHOD zif_abapgit_object~delete.

    DATA: lv_transaction_variant TYPE tcvariant.

    lv_transaction_variant = ms_item-obj_name.

    CALL FUNCTION 'RS_HDSYS_DELETE_VARIANT'
      EXPORTING
        tcvariant                 = lv_transaction_variant
        i_flag_client_independent = abap_true
      EXCEPTIONS
        variant_enqueued          = 1
        no_correction             = 2
        OTHERS                    = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.