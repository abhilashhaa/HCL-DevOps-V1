  METHOD deserialize_docu_xxxx.

    DATA ls_docu LIKE LINE OF it_docu.
    DATA lv_objname TYPE lxeobjname.
    DATA lv_change_flag TYPE char1.
    DATA lv_error_status  TYPE lxestatprc.

    LOOP AT it_docu INTO ls_docu.

      ls_docu-header-tdfuser = sy-uname.
      ls_docu-header-tdfdate = sy-datum.
      ls_docu-header-tdftime = sy-uzeit.

      ls_docu-header-tdluser = sy-uname.
      ls_docu-header-tdldate = sy-datum.
      ls_docu-header-tdltime = sy-uzeit.

      lv_objname = ls_docu-header-tdname.

      CALL FUNCTION 'LXE_OBJ_DOKU_PUT_XSTRING'
        EXPORTING
          slang       = me->mv_language
          tlang       = ls_docu-language
          objtype     = ls_docu-header-tdid
          objname     = lv_objname
          header      = ls_docu-header
          content     = ls_docu-content
        IMPORTING
          change_flag = lv_change_flag
          pstatus     = lv_error_status.

    ENDLOOP.


  ENDMETHOD.