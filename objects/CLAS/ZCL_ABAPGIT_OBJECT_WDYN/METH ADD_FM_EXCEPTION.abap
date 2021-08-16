  METHOD add_fm_exception.

    DATA: ls_exception LIKE LINE OF ct_exception.

    ls_exception-name = iv_name.
    ls_exception-value = iv_value.

    INSERT ls_exception INTO TABLE ct_exception.

  ENDMETHOD.