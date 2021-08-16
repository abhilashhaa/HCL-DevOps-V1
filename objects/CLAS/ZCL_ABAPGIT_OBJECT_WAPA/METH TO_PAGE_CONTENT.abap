  METHOD to_page_content.

    DATA: lv_string TYPE string.


    lv_string = zcl_abapgit_convert=>xstring_to_string_utf8( iv_content ).

    SPLIT lv_string AT zif_abapgit_definitions=>c_newline INTO TABLE rt_content.

  ENDMETHOD.