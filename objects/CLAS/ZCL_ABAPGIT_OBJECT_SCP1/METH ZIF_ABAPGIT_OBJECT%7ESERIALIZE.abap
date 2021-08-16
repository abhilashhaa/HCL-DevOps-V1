  METHOD zif_abapgit_object~serialize.

    DATA: ls_scp1 TYPE ty_scp1.


    ls_scp1-scprattr-id = ms_item-obj_name.

    CALL FUNCTION 'SCPR_DB_ATTR_GET_DETAIL'
      EXPORTING
        profid     = ls_scp1-scprattr-id
      IMPORTING
        proftype   = ls_scp1-scprattr-type
        cli_dep    = ls_scp1-scprattr-cli_dep
        cli_cas    = ls_scp1-scprattr-cli_cas
        reftype    = ls_scp1-scprattr-reftype
        refname    = ls_scp1-scprattr-refname
        component  = ls_scp1-scprattr-component
        minrelease = ls_scp1-scprattr-minrelease
        maxrelease = ls_scp1-scprattr-maxrelease
        orgid      = ls_scp1-scprattr-orgid
        act_info   = ls_scp1-scprattr-act_info.

    CALL FUNCTION 'SCPR_TEXT_GET'
      EXPORTING
        profid        = ls_scp1-scprattr-id
        category      = ls_scp1-scprattr-category
      TABLES
        texts         = ls_scp1-scprtext
      EXCEPTIONS
        no_text_found = 1.

    IF ls_scp1-scprattr-type = 'TMP'.
      load_hier( CHANGING cs_scp1 = ls_scp1 ).
    ELSE.
      load( CHANGING cs_scp1 = ls_scp1 ).
    ENDIF.

    adjust_outbound( CHANGING cs_scp1 = ls_scp1 ).

    io_xml->add(
      iv_name = 'SCP1'
      ig_data  = ls_scp1 ).

  ENDMETHOD.