  METHOD get_t100_longtext.

* method is called dynamically from ZCX_ABAPGIT_EXCEPTION

    rv_longtext = itf_to_string( get_t100_longtext_itf( ) ).

  ENDMETHOD.