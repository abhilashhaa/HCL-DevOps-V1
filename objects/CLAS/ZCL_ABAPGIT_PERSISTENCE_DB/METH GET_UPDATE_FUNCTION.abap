  METHOD get_update_function.
    IF mv_update_function IS INITIAL.
      mv_update_function = 'CALL_V1_PING'.
      CALL FUNCTION 'FUNCTION_EXISTS'
        EXPORTING
          funcname = mv_update_function
        EXCEPTIONS
          OTHERS   = 2.

      IF sy-subrc <> 0.
        mv_update_function = 'BANK_OBJ_WORKL_RELEASE_LOCKS'.
      ENDIF.
    ENDIF.
    rv_funcname = mv_update_function.

  ENDMETHOD.