  METHOD w3_api_get_attributes.

    ii_template->get_attributes(
      IMPORTING
        p_attributes     = rs_attributes
      EXCEPTIONS
        object_invalid   = 1
        template_deleted = 2
        error_occured    = 3
        OTHERS           = 4 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from w3_api_template~get_attributes subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.