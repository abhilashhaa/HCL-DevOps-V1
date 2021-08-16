  METHOD delete_chr_with_bapi.

    DATA(lv_exists) = me->check_chr_exists( iv_characteristic ).

    IF lv_exists = abap_true.
      mo_chr_bapi_util->delete_characteristic( iv_characteristic ).
      COMMIT WORK AND WAIT.

      lv_exists = me->check_chr_exists( iv_characteristic ).

      IF lv_exists = abap_true.
        cl_abap_unit_assert=>fail(
          msg   = |Failed to delete characteristic { iv_characteristic }|
          level = if_aunit_constants=>severity-low ).
      ENDIF.
    ENDIF.

  ENDMETHOD.