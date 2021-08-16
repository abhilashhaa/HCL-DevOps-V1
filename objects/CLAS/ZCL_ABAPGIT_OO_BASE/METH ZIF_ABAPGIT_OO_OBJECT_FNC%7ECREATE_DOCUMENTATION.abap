  METHOD zif_abapgit_oo_object_fnc~create_documentation.
    CALL FUNCTION 'DOCU_UPD'
      EXPORTING
        id            = 'CL'
        langu         = iv_language
        object        = iv_object_name
        no_masterlang = iv_no_masterlang
      TABLES
        line          = it_lines
      EXCEPTIONS
        ret_code      = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from DOCU_UPD. Subrc = { sy-subrc }| ).
    ENDIF.
  ENDMETHOD.