  METHOD save.

    DATA: ls_scp1 TYPE ty_scp1,
          ls_text TYPE scprtext.


* copy everything to local, the function module changes the values
    ls_scp1 = is_scp1.

    READ TABLE ls_scp1-scprtext INTO ls_text WITH KEY langu = mv_language. "#EC CI_SUBRC

    CALL FUNCTION 'SCPR_TEMPL_MN_TEMPLATE_SAVE'
      EXPORTING
        profid                    = ls_scp1-scprattr-id
        proftext                  = ls_text-text
        category                  = ls_scp1-scprattr-category
        cli_dep                   = ls_scp1-scprattr-cli_dep
        cli_cas                   = ls_scp1-scprattr-cli_cas
        reftype                   = ls_scp1-scprattr-reftype
        refname                   = ls_scp1-scprattr-refname
        orgid                     = ls_scp1-scprattr-orgid
        component                 = ls_scp1-scprattr-component
        minrelease                = ls_scp1-scprattr-minrelease
        maxrelease                = ls_scp1-scprattr-maxrelease
        act_info                  = ls_scp1-scprattr-act_info
        bcset_type                = ls_scp1-scprattr-type
        fldtxtvar_supplied        = 'YES'
        with_transp_insert        = abap_false
        with_progress_indicator   = abap_false
        remove_denied_data        = abap_true
        ask_for_cont_after_remove = abap_true
      TABLES
        values                    = ls_scp1-scprvals
        valuesl                   = ls_scp1-scprvall
        recattr                   = ls_scp1-scprreca
        it_fldv                   = ls_scp1-scprfldv
        texts                     = ls_scp1-scprtext
      EXCEPTIONS
        user_abort                = 1
        error_in_transport_layer  = 2
        inconsistent_data         = 3
        database_error            = 4
        OTHERS                    = 5.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error saving SCP1, { sy-subrc }| ).
    ENDIF.

  ENDMETHOD.