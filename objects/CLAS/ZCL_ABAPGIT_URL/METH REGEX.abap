  METHOD regex.

    FIND REGEX '(https?://[^/]*)(.*/)([^\.]*)[\.git]?' IN iv_url
      SUBMATCHES ev_host ev_path ev_name.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Malformed URL' ).
    ENDIF.

  ENDMETHOD.