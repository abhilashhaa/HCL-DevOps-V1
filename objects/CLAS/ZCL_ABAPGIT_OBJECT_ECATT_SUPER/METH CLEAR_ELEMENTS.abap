  METHOD clear_elements.

    clear_element( EXPORTING iv_name     = |FUSER|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |FDATE|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |LUSER|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |LDATE|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |LTIME|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |TWB_RESP|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |DEVCLASS|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |TADIR_RESP|
                   CHANGING  ci_document = ci_document ).

    clear_element( EXPORTING iv_name     = |VAR_EXT_PATH|
                   CHANGING  ci_document = ci_document ).

  ENDMETHOD.