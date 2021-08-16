  METHOD zif_abapgit_object~delete.

    CALL FUNCTION 'EXTTYPE_DELETE'
      EXPORTING
        pi_cimtyp = mv_extension
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.