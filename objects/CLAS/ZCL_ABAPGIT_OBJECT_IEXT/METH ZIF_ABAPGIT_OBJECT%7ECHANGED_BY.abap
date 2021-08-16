  METHOD zif_abapgit_object~changed_by.

    DATA: ls_attributes TYPE edi_iapi01.

    CALL FUNCTION 'EXTTYPE_READ'
      EXPORTING
        pi_cimtyp     = mv_extension
      IMPORTING
        pe_attributes = ls_attributes
      EXCEPTIONS
        OTHERS        = 1.

    rv_user = ls_attributes-plast.

  ENDMETHOD.