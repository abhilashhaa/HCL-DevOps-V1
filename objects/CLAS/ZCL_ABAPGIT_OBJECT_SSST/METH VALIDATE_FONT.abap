  METHOD validate_font.

    DATA: lv_tdfamily TYPE tfo01-tdfamily.


    SELECT SINGLE tdfamily FROM tfo01 INTO lv_tdfamily
      WHERE tdfamily = iv_tdfamily.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Font family not found' ).
    ENDIF.

  ENDMETHOD.