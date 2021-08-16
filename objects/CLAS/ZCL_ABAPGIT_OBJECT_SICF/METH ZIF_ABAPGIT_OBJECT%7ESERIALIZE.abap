  METHOD zif_abapgit_object~serialize.

    DATA: ls_icfservice TYPE icfservice,
          ls_icfdocu    TYPE icfdocu,
          lv_url        TYPE string,
          lt_icfhandler TYPE TABLE OF icfhandler.


    read( IMPORTING es_icfservice = ls_icfservice
                    es_icfdocu    = ls_icfdocu
                    et_icfhandler = lt_icfhandler
                    ev_url        = lv_url ).
    IF ls_icfservice IS INITIAL.
      RETURN.
    ENDIF.

    CLEAR ls_icfservice-icf_mandt.
    CLEAR ls_icfservice-icfnodguid.
    CLEAR ls_icfservice-icfparguid.
    CLEAR ls_icfservice-icf_user.
    CLEAR ls_icfservice-icf_cclnt.
    CLEAR ls_icfservice-icf_mclnt.
    CLEAR ls_icfservice-icfaltnme_orig.
    CLEAR ls_icfservice-icfbitmap.

    io_xml->add( iv_name = 'URL'
                 ig_data = lv_url ).
    io_xml->add( iv_name = 'ICFSERVICE'
                 ig_data = ls_icfservice ).
    io_xml->add( iv_name = 'ICFDOCU'
                 ig_data = ls_icfdocu ).
    io_xml->add( iv_name = 'ICFHANDLER_TABLE'
                 ig_data = lt_icfhandler ).

  ENDMETHOD.