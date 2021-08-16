  METHOD zif_abapgit_object~serialize.

    DATA: ls_idoc TYPE ty_idoc.

    CALL FUNCTION 'IDOCTYPE_READ'
      EXPORTING
        pi_idoctyp       = mv_idoctyp
      IMPORTING
        pe_attributes    = ls_idoc-attributes
      TABLES
        pt_syntax        = ls_idoc-t_syntax
      EXCEPTIONS
        object_not_found = 1
        db_error         = 2
        no_authority     = 3
        OTHERS           = 4.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    clear_idoc_segement_fields( CHANGING cg_structure = ls_idoc-attributes ).

    io_xml->add( iv_name = 'IDOC'
                 ig_data = ls_idoc ).

  ENDMETHOD.