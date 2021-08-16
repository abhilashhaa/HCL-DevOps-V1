  METHOD load.

    CALL FUNCTION 'SCPR_TEMPL_DB_VALS_GET_DETAIL'
      EXPORTING
        profid   = cs_scp1-scprattr-id
        category = cs_scp1-scprattr-category
      TABLES
        values   = cs_scp1-scprvals
        valuesl  = cs_scp1-scprvall
        recattr  = cs_scp1-scprreca.

    CALL FUNCTION 'SCPR_TEMPL_DB_FLDTXTVAR_GET'
      EXPORTING
        bcset_id = cs_scp1-scprattr-id
        category = cs_scp1-scprattr-category
      TABLES
        it_fldv  = cs_scp1-scprfldv.

  ENDMETHOD.