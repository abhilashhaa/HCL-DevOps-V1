  METHOD zif_abapgit_object~serialize.

    DATA: ls_dd25v TYPE dd25v,
          ls_dd09l TYPE dd09l,
          lt_dd26v TYPE tty_dd26v,
          lt_dd27p TYPE tty_dd27p,
          lt_dd28j TYPE tty_dd28j,
          lt_dd28v TYPE tty_dd28v.

    FIELD-SYMBOLS: <ls_dd27p> LIKE LINE OF lt_dd27p.

    read_view(
      IMPORTING
        es_dd25v = ls_dd25v
        es_dd09l = ls_dd09l
        et_dd26v = lt_dd26v
        et_dd27p = lt_dd27p
        et_dd28j = lt_dd28j
        et_dd28v = lt_dd28v ).

    IF ls_dd25v IS INITIAL.
      RETURN. " does not exist in system
    ENDIF.

    CLEAR: ls_dd25v-as4user,
           ls_dd25v-as4date,
           ls_dd25v-as4time.

    CLEAR: ls_dd09l-as4user,
           ls_dd09l-as4date,
           ls_dd09l-as4time.

    LOOP AT lt_dd27p ASSIGNING <ls_dd27p>.
      CLEAR: <ls_dd27p>-ddtext,
             <ls_dd27p>-reptext,
             <ls_dd27p>-scrtext_s,
             <ls_dd27p>-scrtext_m,
             <ls_dd27p>-scrtext_l,
             <ls_dd27p>-outputlen,
             <ls_dd27p>-decimals,
             <ls_dd27p>-lowercase,
             <ls_dd27p>-convexit,
             <ls_dd27p>-signflag,
             <ls_dd27p>-flength,
             <ls_dd27p>-domname,
             <ls_dd27p>-datatype,
             <ls_dd27p>-entitytab,
             <ls_dd27p>-inttype,
             <ls_dd27p>-intlen,
             <ls_dd27p>-headlen,
             <ls_dd27p>-scrlen1,
             <ls_dd27p>-scrlen2,
             <ls_dd27p>-scrlen3,
             <ls_dd27p>-memoryid.
    ENDLOOP.

    io_xml->add( iv_name = 'DD25V'
                 ig_data = ls_dd25v ).
    io_xml->add( iv_name = 'DD09L'
                 ig_data = ls_dd09l ).
    io_xml->add( ig_data = lt_dd26v
                 iv_name = 'DD26V_TABLE' ).
    io_xml->add( ig_data = lt_dd27p
                 iv_name = 'DD27P_TABLE' ).
    io_xml->add( ig_data = lt_dd28j
                 iv_name = 'DD28J_TABLE' ).
    io_xml->add( ig_data = lt_dd28v
                 iv_name = 'DD28V_TABLE' ).

  ENDMETHOD.