  METHOD read_baseinfo.

    TRY.
        rv_baseinfo_string = mo_files->read_string( 'baseinfo' ).

      CATCH zcx_abapgit_exception.
        " File not found. That's ok, as the object could have been created in a
        " system where baseinfo wasn't supported.
        RETURN.
    ENDTRY.

  ENDMETHOD.