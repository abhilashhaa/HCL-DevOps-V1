  METHOD zlib_decompress.

    DATA: ls_data           TYPE zcl_abapgit_zlib=>ty_decompress,
          lv_compressed_len TYPE i,
          lv_adler32        TYPE zif_abapgit_definitions=>ty_adler32.


    ls_data = zcl_abapgit_zlib=>decompress( cv_data ).
    lv_compressed_len = ls_data-compressed_len.
    cv_decompressed = ls_data-raw.

    IF lv_compressed_len IS INITIAL.
      zcx_abapgit_exception=>raise( |Decompression falied :o/| ).
    ENDIF.

    cv_data = cv_data+lv_compressed_len.

    lv_adler32 = zcl_abapgit_hash=>adler32( cv_decompressed ).
    IF cv_data(4) <> lv_adler32.
      cv_data = cv_data+1.
    ENDIF.
    IF cv_data(4) <> lv_adler32.
      cv_data = cv_data+1.
    ENDIF.
    IF cv_data(4) <> lv_adler32.
      zcx_abapgit_exception=>raise( |Wrong Adler checksum| ).
    ENDIF.
  ENDMETHOD.