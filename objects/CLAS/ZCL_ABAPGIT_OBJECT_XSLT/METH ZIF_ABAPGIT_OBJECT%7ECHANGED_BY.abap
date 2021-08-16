  METHOD zif_abapgit_object~changed_by.

    DATA: lo_xslt       TYPE REF TO cl_o2_api_xsltdesc,
          ls_attributes TYPE o2xsltattr.

    lo_xslt = get( ).
    lo_xslt->get_attributes(
      RECEIVING
        p_attributes     = ls_attributes
      EXCEPTIONS
        object_invalid   = 1
        xsltdesc_deleted = 2
        OTHERS           = 3 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    rv_user = ls_attributes-changedby.

  ENDMETHOD.