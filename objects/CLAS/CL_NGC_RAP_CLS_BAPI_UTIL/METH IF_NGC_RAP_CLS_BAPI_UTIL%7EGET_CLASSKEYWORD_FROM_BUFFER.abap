  METHOD if_ngc_rap_cls_bapi_util~get_classkeyword_from_buffer.

    DATA:
      lt_swor TYPE STANDARD TABLE OF swor.

    APPEND VALUE #( clint = is_classkeyword-classinternalid ) TO lt_swor.

    CALL FUNCTION 'CLSE_SELECT_SWOR'
      TABLES
        imp_exp_swor   = lt_swor
      EXCEPTIONS
        no_entry_found = 1
        OTHERS         = 2.

    IF sy-subrc = 0.
      DATA(ls_swor) = VALUE #( lt_swor[ spras = is_classkeyword-language
                                        kschl = is_classkeyword-classkeywordtext ] OPTIONAL ).
      IF ls_swor IS NOT INITIAL.
        rs_classkeyword-classinternalid            = ls_swor-clint.
        rs_classkeyword-language                   = ls_swor-spras.
        rs_classkeyword-classkeywordtext           = ls_swor-kschl.
        rs_classkeyword-classkeywordpositionnumber = ls_swor-klpos.
      ENDIF.
    ENDIF.

  ENDMETHOD.