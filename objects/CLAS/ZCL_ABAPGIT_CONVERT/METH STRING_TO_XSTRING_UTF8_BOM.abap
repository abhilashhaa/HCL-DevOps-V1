  METHOD string_to_xstring_utf8_bom.

    DATA: lv_hex     TYPE x LENGTH 1 VALUE '23',
          lv_hex_bom TYPE x LENGTH 3 VALUE 'EFBBBF'.

    rv_xstring = string_to_xstring_utf8( iv_string ).

    "unicode systems always add the byte order mark to the xml, while non-unicode does not
    "in class ZCL_ABAPGIT_XML~TO_XML byte order mark was added to XML as #
    "In non-unicode systems zcl_abapgit_convert=>xstring_to_string_utf8( cl_abap_char_utilities=>byte_order_mark_utf8 )
    "has result # as HEX 23 and not HEX EFBBBF.
    "So we have to remove 23 first and add EFBBBF after to serialized string
    IF rv_xstring(3) <> cl_abap_char_utilities=>byte_order_mark_utf8
    AND rv_xstring(1) = lv_hex.
      REPLACE FIRST OCCURRENCE
        OF lv_hex IN rv_xstring WITH lv_hex_bom IN BYTE MODE.
      ASSERT sy-subrc = 0.
    ENDIF.

  ENDMETHOD.