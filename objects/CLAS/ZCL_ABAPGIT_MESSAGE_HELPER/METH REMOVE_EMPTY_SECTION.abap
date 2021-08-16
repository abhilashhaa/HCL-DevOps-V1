  METHOD remove_empty_section.
    IF iv_tabix_to BETWEEN iv_tabix_from AND lines( ct_itf ).
      DELETE ct_itf FROM iv_tabix_from TO iv_tabix_to.
    ELSE.
      DELETE ct_itf FROM iv_tabix_from.
    ENDIF.
  ENDMETHOD.