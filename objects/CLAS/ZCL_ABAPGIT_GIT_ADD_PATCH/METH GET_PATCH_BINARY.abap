  METHOD get_patch_binary.

    DATA: lv_string TYPE string.

    IF mt_patch IS INITIAL.
      mt_patch = calculate_patch( ).
    ENDIF.

    CONCATENATE LINES OF mt_patch INTO lv_string SEPARATED BY zif_abapgit_definitions=>c_newline.
    lv_string = lv_string && zif_abapgit_definitions=>c_newline.

    rv_patch_binary = zcl_abapgit_convert=>string_to_xstring_utf8( lv_string ).

  ENDMETHOD.