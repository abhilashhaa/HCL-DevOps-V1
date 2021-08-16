  METHOD serialize_docu_xxxx.

    DATA ls_docu            TYPE ty_docu.
    DATA ls_dokvl           TYPE dokvl.
    DATA lt_dokvl           TYPE STANDARD TABLE OF dokvl.
    DATA lv_error_status    TYPE lxestatprc.
    DATA lv_objname         TYPE lxeobjname.


    ls_dokvl-object = me->build_text_name( iv_id = iv_id ).

    SELECT id object langu
      FROM dokvl
      INTO CORRESPONDING FIELDS OF TABLE lt_dokvl
      WHERE id = c_text_object_type
      AND   object LIKE ls_dokvl-object ##TOO_MANY_ITAB_FIELDS.

    LOOP AT lt_dokvl INTO ls_dokvl.

      ls_docu-language = ls_dokvl-langu.
      lv_objname = ls_dokvl-object.

      " You are reminded that this function gets the most recent version of the texts.
      CALL FUNCTION 'LXE_OBJ_DOKU_GET_XSTRING'
        EXPORTING
          lang    = ls_docu-language
          objtype = c_text_object_type
          objname = lv_objname
        IMPORTING
          header  = ls_docu-header
          content = ls_docu-content
          itf     = ls_docu-itf
          pstatus = lv_error_status.

      CHECK lv_error_status = 'S'. "Success

      " Administrative information is not
      CLEAR ls_docu-header-tdfuser.
      CLEAR ls_docu-header-tdfdate.
      CLEAR ls_docu-header-tdftime.

      CLEAR ls_docu-header-tdluser.
      CLEAR ls_docu-header-tdldate.
      CLEAR ls_docu-header-tdltime.

      APPEND ls_docu TO rt_result.

    ENDLOOP.


  ENDMETHOD.