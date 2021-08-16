  METHOD unpack.

    DATA: lv_new TYPE string,
          lv_old TYPE string.


    lv_new = zcl_abapgit_convert=>xstring_to_string_utf8( iv_new ).
    lv_old = zcl_abapgit_convert=>xstring_to_string_utf8( iv_old ).

    SPLIT lv_new AT zif_abapgit_definitions=>c_newline INTO TABLE et_new.
    SPLIT lv_old AT zif_abapgit_definitions=>c_newline INTO TABLE et_old.

  ENDMETHOD.