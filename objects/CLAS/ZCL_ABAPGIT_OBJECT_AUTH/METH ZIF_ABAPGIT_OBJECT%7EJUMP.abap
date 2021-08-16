  METHOD zif_abapgit_object~jump.
    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname           = 'SU20_MAINTAIN_SNGL'
      EXCEPTIONS
        function_not_exist = 1
        OTHERS             = 2.
    IF sy-subrc = 0.
      " this function module does not exist in 740
      CALL FUNCTION 'SU20_MAINTAIN_SNGL'
        EXPORTING
          id_field    = mv_fieldname
          id_wbo_mode = abap_false.
    ENDIF.
  ENDMETHOD.