  METHOD show_longtext.

    DATA: lx_abapgit TYPE REF TO zcx_abapgit_exception.

    DATA: lv_docu_object TYPE dokhl-object,
          lt_dummy1      TYPE TABLE OF dselc,
          lt_dummy2      TYPE TABLE OF dval,
          ls_help_info   TYPE help_info.

    IF is_log-exception IS NOT BOUND.
      RETURN.
    ENDIF.

    TRY.
        lx_abapgit ?= is_log-exception.
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.

    lv_docu_object   = lx_abapgit->if_t100_message~t100key-msgid.
    lv_docu_object+2 = lx_abapgit->if_t100_message~t100key-msgno.

    ls_help_info-call       = 'D'.
    ls_help_info-spras      = sy-langu.
    ls_help_info-messageid  = lx_abapgit->if_t100_message~t100key-msgid.
    ls_help_info-messagenr  = lx_abapgit->if_t100_message~t100key-msgno.
    ls_help_info-message    = is_log-msg.
    ls_help_info-title      = 'Longtext'.
    ls_help_info-docuid     = 'NA'.
    ls_help_info-docuobject = lv_docu_object.
    ls_help_info-msgv1      = lx_abapgit->msgv1.
    ls_help_info-msgv2      = lx_abapgit->msgv2.
    ls_help_info-msgv3      = lx_abapgit->msgv3.
    ls_help_info-msgv4      = lx_abapgit->msgv4.

    CALL FUNCTION 'HELP_START'
      EXPORTING
        help_infos   = ls_help_info
      TABLES
        dynpselect   = lt_dummy1
        dynpvaluetab = lt_dummy2
      EXCEPTIONS
        OTHERS       = 1.

    IF sy-subrc IS NOT INITIAL.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.