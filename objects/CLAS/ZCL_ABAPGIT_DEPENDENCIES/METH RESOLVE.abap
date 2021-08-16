  METHOD resolve.

    DATA: lv_tabclass TYPE dd02l-tabclass.

    FIELD-SYMBOLS: <ls_tadir> LIKE LINE OF ct_tadir.

    " misuse field KORRNUM to fix deletion sequence

    LOOP AT ct_tadir ASSIGNING <ls_tadir>.
      CASE <ls_tadir>-object.
        WHEN 'DEVC'.
          " Packages last
          <ls_tadir>-korrnum = '999000'.
        WHEN 'DOMA'.
          <ls_tadir>-korrnum = '900000'.
        WHEN 'PARA'.
          " PARA after DTEL
          <ls_tadir>-korrnum = '810000'.
        WHEN 'DTEL'.
          <ls_tadir>-korrnum = '800000'.
        WHEN 'DCLS'.
          " AUTH and SUSO after DCLS
          <ls_tadir>-korrnum = '705000'.
        WHEN 'SUSO'.
          " SUSO after DCLS
          <ls_tadir>-korrnum = '710000'.
        WHEN 'AUTH'.
          " AUTH after DCLS
          <ls_tadir>-korrnum = '715000'.
        WHEN 'DDLS'.
          " DDLS after DCLS but before other DDIC
          <ls_tadir>-korrnum = '720000'.
        WHEN 'TTYP' OR 'TABL' OR 'VIEW'.
          SELECT SINGLE tabclass FROM dd02l
            INTO lv_tabclass
            WHERE tabname = <ls_tadir>-obj_name
            AND as4local = 'A'
            AND as4vers = '0000'.
          IF sy-subrc = 0 AND lv_tabclass = 'APPEND'.
            " delete append structures before database tables
            <ls_tadir>-korrnum = '730000'.
          ELSE.
            <ls_tadir>-korrnum = '750000'.
          ENDIF.
        WHEN 'IASP'.
          <ls_tadir>-korrnum = '552000'.
        WHEN 'IARP'.
          <ls_tadir>-korrnum = '551000'.
        WHEN 'IATU'.
          <ls_tadir>-korrnum = '550000'.
        WHEN 'SUSC'.
          <ls_tadir>-korrnum = '500000'.
        WHEN 'ACID'.
          " ACID after PROG/FUGR/CLAS
          <ls_tadir>-korrnum = '300000'.
        WHEN 'PROG'.
          " delete includes after main programs
          SELECT COUNT(*) FROM reposrc
            WHERE progname = <ls_tadir>-obj_name
            AND r3state = 'A'
            AND subc = 'I'.
          IF sy-subrc = 0.
            <ls_tadir>-korrnum = '200000'.
          ELSE.
            <ls_tadir>-korrnum = '100000'.
          ENDIF.
        WHEN 'IDOC'.
          <ls_tadir>-korrnum = '200000'.
        WHEN 'WDCA'.
          <ls_tadir>-korrnum = '174000'.
        WHEN 'WDYA'.
          <ls_tadir>-korrnum = '173000'.
        WHEN 'WDCC'.
          <ls_tadir>-korrnum = '172000'.
        WHEN 'WDYN'.
          <ls_tadir>-korrnum = '171000'.
        WHEN 'IEXT'.
          <ls_tadir>-korrnum = '150000'.
        WHEN OTHERS.
          <ls_tadir>-korrnum = '100000'.
      ENDCASE.
    ENDLOOP.

    resolve_ddic( CHANGING ct_tadir = ct_tadir ).
    resolve_packages( CHANGING ct_tadir = ct_tadir ).

    SORT ct_tadir BY korrnum ASCENDING.

  ENDMETHOD.