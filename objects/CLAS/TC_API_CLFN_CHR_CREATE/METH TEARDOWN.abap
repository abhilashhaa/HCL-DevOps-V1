  METHOD TEARDOWN.

    me->delete_chr_with_bapi( ms_chr_multiple-characteristic ).

  ENDMETHOD.