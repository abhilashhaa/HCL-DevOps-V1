  METHOD add_data.

    DATA: ls_bcdata LIKE LINE OF mt_bcdata.

    ls_bcdata-fnam = iv_fnam.
    ls_bcdata-fval = iv_fval.
    APPEND ls_bcdata TO mt_bcdata.

  ENDMETHOD.