  METHOD zif_abapgit_object~serialize.

    DATA: lv_name   TYPE ddobjname,
          ls_dd02v  TYPE dd02v,
          ls_dd09l  TYPE dd09l,
          lt_dd03p  TYPE ty_dd03p_tt,
          lt_dd05m  TYPE TABLE OF dd05m,
          lt_dd08v  TYPE TABLE OF dd08v,
          lt_dd12v  TYPE dd12vtab,
          lt_dd17v  TYPE dd17vtab,
          lt_dd35v  TYPE TABLE OF dd35v,
          lv_index  LIKE sy-index,
          lt_dd36m  TYPE dd36mttyp,
          ls_extras TYPE ty_tabl_extras.

    FIELD-SYMBOLS: <ls_dd12v>      LIKE LINE OF lt_dd12v,
                   <ls_dd05m>      LIKE LINE OF lt_dd05m,
                   <ls_dd36m>      LIKE LINE OF lt_dd36m,
                   <lg_roworcolst> TYPE any.


    lv_name = ms_item-obj_name.

    CALL FUNCTION 'DDIF_TABL_GET'
      EXPORTING
        name          = lv_name
        langu         = mv_language
      IMPORTING
        dd02v_wa      = ls_dd02v
        dd09l_wa      = ls_dd09l
      TABLES
        dd03p_tab     = lt_dd03p
        dd05m_tab     = lt_dd05m
        dd08v_tab     = lt_dd08v
        dd12v_tab     = lt_dd12v
        dd17v_tab     = lt_dd17v
        dd35v_tab     = lt_dd35v
        dd36m_tab     = lt_dd36m
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from DDIF_TABL_GET' ).
    ENDIF.
    IF ls_dd02v IS INITIAL.
      RETURN. " object does not exits
    ENDIF.

    CLEAR: ls_dd02v-as4user,
           ls_dd02v-as4date,
           ls_dd02v-as4time.

* reset numeric field, so XML does not crash
    IF ls_dd02v-prozpuff = ''.
      CLEAR ls_dd02v-prozpuff.
    ENDIF.
    IF ls_dd02v-datmin = ''.
      CLEAR ls_dd02v-datmin.
    ENDIF.
    IF ls_dd02v-datmax = ''.
      CLEAR ls_dd02v-datmax.
    ENDIF.
    IF ls_dd02v-datavg = ''.
      CLEAR ls_dd02v-datavg.
    ENDIF.

    CLEAR: ls_dd09l-as4user,
           ls_dd09l-as4date,
           ls_dd09l-as4time.

    ASSIGN COMPONENT 'ROWORCOLST' OF STRUCTURE ls_dd09l TO <lg_roworcolst>.
    IF sy-subrc = 0 AND <lg_roworcolst> = 'C'.
      CLEAR <lg_roworcolst>. "To avoid diff errors. This field doesn't exists in all releases
    ENDIF.


    LOOP AT lt_dd12v ASSIGNING <ls_dd12v>.
      CLEAR: <ls_dd12v>-as4user,
             <ls_dd12v>-as4date,
             <ls_dd12v>-as4time.
    ENDLOOP.

    clear_dd03p_fields( CHANGING ct_dd03p = lt_dd03p ).

* remove foreign keys inherited from .INCLUDEs
    DELETE lt_dd08v WHERE noinherit = 'N'.
    LOOP AT lt_dd05m ASSIGNING <ls_dd05m>.
      lv_index = sy-tabix.
      READ TABLE lt_dd08v WITH KEY fieldname = <ls_dd05m>-fieldname TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        DELETE lt_dd05m INDEX lv_index.
      ENDIF.
    ENDLOOP.

* remove inherited search helps
    DELETE lt_dd35v WHERE shlpinher = abap_true.
    LOOP AT lt_dd36m ASSIGNING <ls_dd36m>.
      lv_index = sy-tabix.
      READ TABLE lt_dd35v WITH KEY fieldname = <ls_dd36m>-fieldname TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        DELETE lt_dd36m INDEX lv_index.
      ENDIF.
    ENDLOOP.

    io_xml->add( iv_name = 'DD02V'
                 ig_data = ls_dd02v ).
    IF NOT ls_dd09l IS INITIAL.
      io_xml->add( iv_name = 'DD09L'
                   ig_data = ls_dd09l ).
    ENDIF.
    io_xml->add( iv_name = 'DD03P_TABLE'
                 ig_data = lt_dd03p ).
    io_xml->add( iv_name = 'DD05M_TABLE'
                 ig_data = lt_dd05m ).
    io_xml->add( iv_name = 'DD08V_TABLE'
                 ig_data = lt_dd08v ).
    io_xml->add( iv_name = 'DD12V'
                 ig_data = lt_dd12v ).
    io_xml->add( iv_name = 'DD17V'
                 ig_data = lt_dd17v ).
    io_xml->add( iv_name = 'DD35V_TALE'
                 ig_data = lt_dd35v ).
    io_xml->add( iv_name = 'DD36M'
                 ig_data = lt_dd36m ).

    serialize_texts( io_xml ).

    serialize_longtexts( ii_xml         = io_xml
                         iv_longtext_id = c_longtext_id_tabl ).

    serialize_idoc_segment( io_xml ).

    ls_extras = read_extras( iv_tabname = lv_name ).
    io_xml->add( iv_name = c_s_dataname-tabl_extras
                 ig_data = ls_extras ).

  ENDMETHOD.