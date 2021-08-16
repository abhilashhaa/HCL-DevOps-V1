  METHOD zif_abapgit_object~deserialize.

    DATA: ls_icfservice TYPE icfservice,
          ls_read       TYPE icfservice,
          ls_icfdocu    TYPE icfdocu,
          lv_url        TYPE string,
          lv_exists     TYPE abap_bool,
          lt_icfhandler TYPE TABLE OF icfhandler.


    io_xml->read( EXPORTING iv_name = 'URL'
                  CHANGING cg_data = lv_url ).
    io_xml->read( EXPORTING iv_name = 'ICFSERVICE'
                  CHANGING cg_data = ls_icfservice ).
    io_xml->read( EXPORTING iv_name = 'ICFDOCU'
                  CHANGING cg_data = ls_icfdocu ).
    io_xml->read( EXPORTING iv_name = 'ICFHANDLER_TABLE'
                  CHANGING cg_data = lt_icfhandler ).


    lv_exists = zif_abapgit_object~exists( ).
    IF lv_exists = abap_false.
      insert_sicf( is_icfservice = ls_icfservice
                   is_icfdocu    = ls_icfdocu
                   it_icfhandler = lt_icfhandler
                   iv_package    = iv_package
                   iv_url        = lv_url ).
    ELSE.
      read( IMPORTING es_icfservice = ls_read ).
      change_sicf( is_icfservice = ls_icfservice
                   is_icfdocu    = ls_icfdocu
                   it_icfhandler = lt_icfhandler
                   iv_package    = iv_package
                   iv_parent     = ls_read-icfparguid ).
    ENDIF.

  ENDMETHOD.