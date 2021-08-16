  METHOD get_t100_longtext_itf.

    DATA: lv_docu_key TYPE doku_obj.

    lv_docu_key = ms_t100key-msgid && ms_t100key-msgno.

    CALL FUNCTION 'DOCU_GET'
      EXPORTING
        id     = 'NA'
        langu  = sy-langu
        object = lv_docu_key
        typ    = 'E'
      TABLES
        line   = rt_itf
      EXCEPTIONS
        OTHERS = 1.

    IF sy-subrc = 0.
      sy-msgv1 = set_single_msg_var( iv_arg = ms_t100key-attr1 ).

      REPLACE ALL OCCURRENCES OF '&V1&' IN TABLE rt_itf WITH sy-msgv1.

      sy-msgv2 = set_single_msg_var( iv_arg = ms_t100key-attr2 ).

      REPLACE ALL OCCURRENCES OF '&V2&' IN TABLE rt_itf WITH sy-msgv2.

      sy-msgv3 = set_single_msg_var( iv_arg = ms_t100key-attr3 ).

      REPLACE ALL OCCURRENCES OF '&V3&' IN TABLE rt_itf WITH sy-msgv3.

      sy-msgv4 = set_single_msg_var( iv_arg = ms_t100key-attr4 ).

      REPLACE ALL OCCURRENCES OF '&V4&' IN TABLE rt_itf WITH sy-msgv4.
    ENDIF.

  ENDMETHOD.