  METHOD is_binary.

    FIELD-SYMBOLS <lv_data> LIKE iv_d1.

    IF iv_d1 IS NOT INITIAL. " One of them might be new and so empty
      ASSIGN iv_d1 TO <lv_data>.
    ELSE.
      ASSIGN iv_d2 TO <lv_data>.
    ENDIF.

    rv_yes = zcl_abapgit_utils=>is_binary( <lv_data> ).

  ENDMETHOD.