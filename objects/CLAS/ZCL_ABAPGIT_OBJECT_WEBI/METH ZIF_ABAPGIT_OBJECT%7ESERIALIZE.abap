  METHOD zif_abapgit_object~serialize.

    DATA: ls_webi    TYPE ty_webi,
          lt_modilog TYPE STANDARD TABLE OF smodilog WITH DEFAULT KEY,
          li_vi      TYPE REF TO if_ws_md_vif,
          lv_name    TYPE vepname.

    FIELD-SYMBOLS: <ls_vepheader>   LIKE LINE OF ls_webi-pvepheader,
                   <ls_vependpoint> LIKE LINE OF ls_webi-pvependpoint,
                   <ls_wsheader>    TYPE wsheader.

    CALL FUNCTION 'WEBI_GET_OBJECT'
      EXPORTING
        webiname          = ms_item-obj_name
      TABLES
        psmodilog         = lt_modilog
        pvepheader        = ls_webi-pvepheader
        pvepfunction      = ls_webi-pvepfunction
        pvepfault         = ls_webi-pvepfault
        pvepparameter     = ls_webi-pvepparameter
        pveptype          = ls_webi-pveptype
        pvepelemtype      = ls_webi-pvepelemtype
        pveptabletype     = ls_webi-pveptabletype
        pvepstrutype      = ls_webi-pvepstrutype
        pveptypesoapext   = ls_webi-pveptypesoapext
        pvepeletypsoap    = ls_webi-pvepeletypsoap
        pveptabtypsoap    = ls_webi-pveptabtypsoap
        pvepfuncsoapext   = ls_webi-pvepfuncsoapext
        pvepfieldref      = ls_webi-pvepfieldref
        pvependpoint      = ls_webi-pvependpoint
        pvepvisoapext     = ls_webi-pvepvisoapext
        pvepparasoapext   = ls_webi-pvepparasoapext
        pwsheader         = ls_webi-pwsheader
        pwssoapprop       = ls_webi-pwssoapprop
      EXCEPTIONS
        version_not_found = 1
        webi_not_exist    = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from WEBI_GET_OBJECT' ).
    ENDIF.

    SORT ls_webi-pveptype BY
      vepname ASCENDING
      version ASCENDING
      typename ASCENDING.

    lv_name = ms_item-obj_name.
    TRY.
        li_vi = cl_ws_md_factory=>get_vif_root( )->get_virtual_interface( lv_name ).
        ls_webi-veptext = li_vi->get_short_text( sews_c_vif_version-active ).
      CATCH cx_ws_md_exception.
        zcx_abapgit_exception=>raise( 'error serializing WEBI' ).
    ENDTRY.

    LOOP AT ls_webi-pvepheader ASSIGNING <ls_vepheader>.
      CLEAR <ls_vepheader>-author.
      CLEAR <ls_vepheader>-createdon.
      CLEAR <ls_vepheader>-changedby.
      CLEAR <ls_vepheader>-changedon.
      CLEAR <ls_vepheader>-ctime.
      CLEAR <ls_vepheader>-text_id.
      CLEAR <ls_vepheader>-utime.
      CLEAR <ls_vepheader>-wsint_version.
    ENDLOOP.

    LOOP AT ls_webi-pvependpoint ASSIGNING <ls_vependpoint>.
      CLEAR <ls_vependpoint>-clustd.
    ENDLOOP.

    LOOP AT ls_webi-pwsheader ASSIGNING <ls_wsheader>.

      CLEAR:
        <ls_wsheader>-author,
        <ls_wsheader>-createdon,
        <ls_wsheader>-changedby,
        <ls_wsheader>-changedon,
        <ls_wsheader>-ctime,
        <ls_wsheader>-utime.

    ENDLOOP.

    io_xml->add( iv_name = 'WEBI'
                 ig_data = ls_webi ).

    zcl_abapgit_sotr_handler=>read_sotr(
      iv_pgmid    = 'R3TR'
      iv_object   = ms_item-obj_type
      iv_obj_name = ms_item-obj_name
      io_xml      = io_xml ).

  ENDMETHOD.