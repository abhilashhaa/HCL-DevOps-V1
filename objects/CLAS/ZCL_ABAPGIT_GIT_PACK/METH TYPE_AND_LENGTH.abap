  METHOD type_and_length.

* see http://stefan.saasen.me/articles/git-clone-in-haskell-from-the-bottom-up/#pack_file_objects

    DATA: lv_type   TYPE i,
          lv_length TYPE i,
          lv_hex    TYPE x LENGTH 1.


    CASE iv_type.
      WHEN zif_abapgit_definitions=>c_type-commit.
        lv_type = 16.
      WHEN zif_abapgit_definitions=>c_type-tree.
        lv_type = 32.
      WHEN zif_abapgit_definitions=>c_type-blob.
        lv_type = 48.
      WHEN zif_abapgit_definitions=>c_type-tag.
        lv_type = 64.
      WHEN zif_abapgit_definitions=>c_type-ref_d.
        lv_type = 112.
      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |Unexpected object type while encoding pack| ).
    ENDCASE.

    lv_length = iv_length.

* first byte
    IF lv_length > 15.
      lv_hex = 128.
    ENDIF.
    lv_hex = lv_hex + lv_type + lv_length MOD 16.
    rv_xstring = lv_hex.
    lv_length = lv_length DIV 16.

* subsequent bytes
    WHILE lv_length >= 128.
      lv_hex = 128 + lv_length MOD 128.
      CONCATENATE rv_xstring lv_hex INTO rv_xstring IN BYTE MODE.
      lv_length = lv_length DIV 128.
    ENDWHILE.

* last byte
    IF lv_length > 0.
      lv_hex = lv_length.
      CONCATENATE rv_xstring lv_hex INTO rv_xstring IN BYTE MODE.
    ENDIF.

  ENDMETHOD.