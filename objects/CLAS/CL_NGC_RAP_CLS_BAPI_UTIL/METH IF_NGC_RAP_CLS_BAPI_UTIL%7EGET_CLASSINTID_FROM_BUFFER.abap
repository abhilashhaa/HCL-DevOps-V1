  METHOD if_ngc_rap_cls_bapi_util~get_classintid_from_buffer.

    DATA:
      lt_klah TYPE STANDARD TABLE OF klah.

    APPEND VALUE #( klart = iv_classtype
                    class = iv_class ) TO lt_klah.

    CALL FUNCTION 'CLSE_SELECT_KLAH'
      TABLES
        imp_exp_klah   = lt_klah
      EXCEPTIONS
        no_entry_found = 1
        OTHERS         = 2.

    IF sy-subrc = 0.
      DATA(ls_class) = VALUE #( lt_klah[ klart = iv_classtype
                                         class = iv_class ] OPTIONAL ).
      IF ls_class IS NOT INITIAL.
        rs_classinternalid = ls_class-clint.
      ENDIF.
    ENDIF.

  ENDMETHOD.