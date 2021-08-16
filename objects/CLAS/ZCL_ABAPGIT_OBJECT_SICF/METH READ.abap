  METHOD read.

    DATA: lt_serv_info TYPE icfservtbl,
          ls_serv_info LIKE LINE OF lt_serv_info,
          ls_key       TYPE ty_sicf_key.

    FIELD-SYMBOLS: <ls_icfhandler> LIKE LINE OF et_icfhandler.


    CLEAR es_icfservice.
    CLEAR es_icfdocu.
    CLEAR et_icfhandler.
    CLEAR ev_url.

    ls_key = read_tadir_sicf( ms_item-obj_name )-obj_name.

    cl_icf_tree=>if_icf_tree~get_info_from_serv(
      EXPORTING
        icf_name          = ls_key-icf_name
        icfparguid        = ls_key-icfparguid
        icf_langu         = mv_language
      IMPORTING
        serv_info         = lt_serv_info
        icfdocu           = es_icfdocu
        url               = ev_url
      EXCEPTIONS
        wrong_name        = 1
        wrong_parguid     = 2
        incorrect_service = 3
        no_authority      = 4
        OTHERS            = 5 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |SICF - error from get_info_from_serv. Subrc = { sy-subrc }| ).
    ENDIF.

    ASSERT lines( lt_serv_info ) = 1.
    READ TABLE lt_serv_info INDEX 1 INTO ls_serv_info.
    ASSERT sy-subrc = 0.

    MOVE-CORRESPONDING ls_serv_info-service TO es_icfservice.
    IF iv_clear = abap_true.
      CLEAR es_icfservice-icf_cuser.
      CLEAR es_icfservice-icf_cdate.
      CLEAR es_icfservice-icf_muser.
      CLEAR es_icfservice-icf_mdate.
    ENDIF.

    CLEAR es_icfdocu-icfparguid.

    APPEND LINES OF ls_serv_info-handlertbl TO et_icfhandler.
    LOOP AT et_icfhandler ASSIGNING <ls_icfhandler>.
      CLEAR <ls_icfhandler>-icfparguid.
    ENDLOOP.

  ENDMETHOD.