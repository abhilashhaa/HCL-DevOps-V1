  METHOD zif_abapgit_object~deserialize.

    DATA: ls_idoc       TYPE ty_idoc,
          ls_attributes TYPE edi_iapi05.

    io_xml->read(
      EXPORTING
        iv_name = 'IDOC'
      CHANGING
        cg_data = ls_idoc ).

    MOVE-CORRESPONDING ls_idoc-attributes TO ls_attributes.

    CALL FUNCTION 'IDOCTYPE_CREATE'
      EXPORTING
        pi_idoctyp    = mv_idoctyp
        pi_devclass   = iv_package
        pi_attributes = ls_attributes
      TABLES
        pt_syntax     = ls_idoc-t_syntax
      EXCEPTIONS
        OTHERS        = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.