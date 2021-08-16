  METHOD zif_abapgit_object~serialize.

    DATA: lv_transaction TYPE tstc-tcode,
          ls_tcode       TYPE tstc,
          ls_tstct       TYPE tstct,
          ls_tstcp       TYPE tstcp,
          lt_tstca       TYPE tty_tstca,
          ls_gui_attr    TYPE tstcc.


    lv_transaction = ms_item-obj_name.

    transaction_read( EXPORTING iv_transaction = lv_transaction
                      IMPORTING es_transaction = ls_tcode
                                es_gui_attr    = ls_gui_attr ).
    IF ls_tcode IS INITIAL.
      RETURN.
    ENDIF.

    SELECT SINGLE * FROM tstct INTO ls_tstct
      WHERE sprsl = mv_language
      AND tcode = lv_transaction.         "#EC CI_SUBRC "#EC CI_GENBUFF

    SELECT SINGLE * FROM tstcp INTO ls_tstcp
      WHERE tcode = lv_transaction.       "#EC CI_SUBRC "#EC CI_GENBUFF

    SELECT * FROM tstca INTO TABLE lt_tstca
      WHERE tcode = lv_transaction.
    IF sy-subrc <> 0.
      CLEAR: lt_tstca.
    ENDIF.

    io_xml->add( iv_name = 'TSTC'
                 ig_data = ls_tcode ).
    io_xml->add( iv_name = 'TSTCC'
                 ig_data = ls_gui_attr ).
    io_xml->add( iv_name = 'TSTCT'
                 ig_data = ls_tstct ).
    IF ls_tstcp IS NOT INITIAL.
      io_xml->add( iv_name = 'TSTCP'
                   ig_data = ls_tstcp ).
    ENDIF.
    io_xml->add( iv_name = 'AUTHORIZATIONS'
                 ig_data = lt_tstca ).

    " Texts serializing (translations)
    serialize_texts( io_xml ).

  ENDMETHOD.