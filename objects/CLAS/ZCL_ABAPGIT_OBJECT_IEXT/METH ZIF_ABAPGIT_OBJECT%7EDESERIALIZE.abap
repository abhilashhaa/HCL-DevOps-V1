  METHOD zif_abapgit_object~deserialize.

    DATA: ls_extension  TYPE ty_extention,
          ls_attributes TYPE edi_iapi05.

    io_xml->read( EXPORTING iv_name = c_dataname_iext
                  CHANGING  cg_data = ls_extension ).

    MOVE-CORRESPONDING ls_extension-attributes TO ls_attributes.
    ls_attributes-presp = cl_abap_syst=>get_user_name( ).
    ls_attributes-pwork = ls_attributes-presp.

    IF me->zif_abapgit_object~exists( ) = abap_true.
      CALL FUNCTION 'EXTTYPE_UPDATE'
        EXPORTING
          pi_cimtyp     = mv_extension
          pi_attributes = ls_attributes
        TABLES
          pt_syntax     = ls_extension-t_syntax
        EXCEPTIONS
          OTHERS        = 1.
    ELSE.
      CALL FUNCTION 'EXTTYPE_CREATE'
        EXPORTING
          pi_cimtyp     = mv_extension
          pi_devclass   = iv_package
          pi_attributes = ls_attributes
        TABLES
          pt_syntax     = ls_extension-t_syntax
        EXCEPTIONS
          OTHERS        = 1.
    ENDIF.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.


  ENDMETHOD.