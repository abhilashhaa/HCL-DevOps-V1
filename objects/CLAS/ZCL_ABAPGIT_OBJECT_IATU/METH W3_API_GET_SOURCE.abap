  METHOD w3_api_get_source.

    ii_template->get_source(
      IMPORTING
        p_source         = rt_source
      EXCEPTIONS
        object_invalid   = 1
        template_deleted = 2
        error_occured    = 3
        OTHERS           = 4 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_template~get_source subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.