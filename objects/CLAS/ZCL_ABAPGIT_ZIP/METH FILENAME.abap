  METHOD filename.

    IF iv_str CA '/'.
      FIND REGEX '(.*/)(.*)' IN iv_str
        SUBMATCHES ev_path ev_filename.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'Malformed path' ).
      ENDIF.
      IF ev_path <> '/'.
        CONCATENATE '/' ev_path INTO ev_path.
      ENDIF.
    ELSE.
      ev_path = '/'.
      ev_filename = iv_str.
    ENDIF.
    TRANSLATE ev_filename TO LOWER CASE.

  ENDMETHOD.