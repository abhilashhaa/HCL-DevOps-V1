  METHOD encode_tag.

    DATA: lv_string TYPE string,
          lv_time   TYPE zcl_abapgit_time=>ty_unixtime.

    lv_time = zcl_abapgit_time=>get_unix( ).

    lv_string = |object { is_tag-object }{ zif_abapgit_definitions=>c_newline }|
             && |type { is_tag-type }{ zif_abapgit_definitions=>c_newline }|
             && |tag { zcl_abapgit_git_tag=>remove_tag_prefix( is_tag-tag ) }{ zif_abapgit_definitions=>c_newline }|
             && |tagger { is_tag-tagger_name } <{ is_tag-tagger_email }> { lv_time }|
             && |{ zif_abapgit_definitions=>c_newline }|
             && |{ zif_abapgit_definitions=>c_newline }|
             && |{ is_tag-message }|.

    rv_data = zcl_abapgit_convert=>string_to_xstring_utf8( lv_string ).

  ENDMETHOD.