  METHOD zif_abapgit_longtexts~deserialize.

    DATA: lt_longtexts     TYPE tty_longtexts,
          lv_no_masterlang TYPE dokil-masterlang.
    FIELD-SYMBOLS: <ls_longtext> TYPE ty_longtext.

    ii_xml->read(
      EXPORTING
        iv_name = iv_longtext_name
      CHANGING
        cg_data = lt_longtexts ).

    LOOP AT lt_longtexts ASSIGNING <ls_longtext>.

      lv_no_masterlang = boolc( iv_master_language <> <ls_longtext>-dokil-langu ).

      CALL FUNCTION 'DOCU_UPDATE'
        EXPORTING
          head          = <ls_longtext>-head
          state         = c_docu_state_active
          typ           = <ls_longtext>-dokil-typ
          version       = <ls_longtext>-dokil-version
          no_masterlang = lv_no_masterlang
        TABLES
          line          = <ls_longtext>-lines.

    ENDLOOP.

  ENDMETHOD.