  METHOD zif_abapgit_object~serialize.

    DATA: lv_name  TYPE ddobjname,
          ls_dd25v TYPE dd25v,
          lt_dd26e TYPE TABLE OF dd26e,
          lt_dd27p TYPE tyt_dd27p.

    lv_name = ms_item-obj_name.

    CALL FUNCTION 'DDIF_ENQU_GET'
      EXPORTING
        name          = lv_name
        state         = 'A'
        langu         = mv_language
      IMPORTING
        dd25v_wa      = ls_dd25v
      TABLES
        dd26e_tab     = lt_dd26e
        dd27p_tab     = lt_dd27p
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from DDIF_ENQU_GET' ).
    ENDIF.
    IF ls_dd25v IS INITIAL.
      RETURN. " does not exist in system
    ENDIF.

    CLEAR: ls_dd25v-as4user,
           ls_dd25v-as4date,
           ls_dd25v-as4time,
           ls_dd25v-as4local,
           ls_dd25v-as4vers.

    _clear_dd27p_fields( CHANGING ct_dd27p = lt_dd27p ).

    io_xml->add( iv_name = 'DD25V'
                 ig_data = ls_dd25v ).
    io_xml->add( ig_data = lt_dd26e
                 iv_name = 'DD26E_TABLE' ).
    io_xml->add( ig_data = lt_dd27p
                 iv_name = 'DD27P_TABLE' ).

  ENDMETHOD.