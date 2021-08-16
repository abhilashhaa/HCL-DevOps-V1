  METHOD md5.

    DATA: lv_xstr TYPE xstring,
          lv_hash TYPE xstring.


    lv_xstr = zcl_abapgit_convert=>string_to_xstring_utf8( iv_data ).

    CALL FUNCTION 'CALCULATE_HASH_FOR_RAW'
      EXPORTING
        alg            = 'MD5'
        data           = lv_xstr
      IMPORTING
        hashxstring    = lv_hash
      EXCEPTIONS
        unknown_alg    = 1
        param_error    = 2
        internal_error = 3
        OTHERS         = 4.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from CALCULATE_HASH_FOR_RAW' ).
    ENDIF.

    rv_hash = lv_hash.
    TRANSLATE rv_hash TO LOWER CASE.

  ENDMETHOD.