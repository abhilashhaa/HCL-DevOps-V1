  METHOD zif_abapgit_object~serialize.

    DATA ls_extension           TYPE ty_extention.

    CALL FUNCTION 'EXTTYPE_READ'
      EXPORTING
        pi_cimtyp     = mv_extension
      IMPORTING
        pe_attributes = ls_extension-attributes
      TABLES
        pt_syntax     = ls_extension-t_syntax
      EXCEPTIONS
        OTHERS        = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    zcl_abapgit_object_idoc=>clear_idoc_segement_fields( CHANGING cg_structure = ls_extension-attributes ).

    io_xml->add( iv_name = c_dataname_iext
                 ig_data = ls_extension ).

  ENDMETHOD.