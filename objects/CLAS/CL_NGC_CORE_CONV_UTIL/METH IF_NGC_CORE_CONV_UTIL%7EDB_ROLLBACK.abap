  METHOD if_ngc_core_conv_util~db_rollback.

    ROLLBACK CONNECTION default.                     "#EC CI_ROLLBACK

  ENDMETHOD.