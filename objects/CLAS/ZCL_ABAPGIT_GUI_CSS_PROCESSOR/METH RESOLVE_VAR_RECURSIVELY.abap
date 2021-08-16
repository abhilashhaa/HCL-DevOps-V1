  METHOD resolve_var_recursively.
    CONSTANTS: lc_variable_usage_pattern TYPE string VALUE `var\(\-\-([^\)]*)\)`.
    DATA: lv_variable_name  TYPE string.
    FIELD-SYMBOLS: <ls_variable>       LIKE LINE OF ct_variables,
                   <ls_other_variable> LIKE LINE OF ct_variables.

    READ TABLE ct_variables WITH TABLE KEY name = iv_variable_name ASSIGNING <ls_variable>.
    IF sy-subrc = 0.
      DO.
        FIND FIRST OCCURRENCE OF REGEX lc_variable_usage_pattern
             IN <ls_variable>-value
             SUBMATCHES lv_variable_name.
        IF sy-subrc = 0.
          resolve_var_recursively( EXPORTING iv_variable_name = lv_variable_name
                                   CHANGING  ct_variables     = ct_variables ).
          READ TABLE ct_variables WITH TABLE KEY name = lv_variable_name ASSIGNING <ls_other_variable>.
          REPLACE FIRST OCCURRENCE OF |var(--{ lv_variable_name })|
                  IN <ls_variable>-value
                  WITH <ls_other_variable>-value.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.
    ELSE.
      zcx_abapgit_exception=>raise( |CSS variable { iv_variable_name } not resolveable| ).
    ENDIF.
  ENDMETHOD.