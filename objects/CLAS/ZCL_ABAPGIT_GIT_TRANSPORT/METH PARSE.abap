  METHOD parse.

    CONSTANTS: lc_band1 TYPE x VALUE '01'.

    DATA: lv_len      TYPE i,
          lv_contents TYPE xstring,
          lv_pack     TYPE xstring.


    WHILE xstrlen( cv_data ) >= 4.
      lv_len = zcl_abapgit_git_utils=>length_utf8_hex( cv_data ).

      IF lv_len > xstrlen( cv_data ).
        zcx_abapgit_exception=>raise( 'parse, string length too large' ).
      ENDIF.

      lv_contents = cv_data(lv_len).
      IF lv_len = 0.
        cv_data = cv_data+4.
        CONTINUE.
      ELSE.
        cv_data = cv_data+lv_len.
      ENDIF.

      lv_contents = lv_contents+4.

      IF xstrlen( lv_contents ) > 1 AND lv_contents(1) = lc_band1.
        CONCATENATE lv_pack lv_contents+1 INTO lv_pack IN BYTE MODE.
      ENDIF.

    ENDWHILE.

    ev_pack = lv_pack.

  ENDMETHOD.