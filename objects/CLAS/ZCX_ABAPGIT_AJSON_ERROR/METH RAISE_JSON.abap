  METHOD raise_json.

    DATA lv_tmp TYPE string.
    DATA:
      BEGIN OF ls_msg,
        a1 LIKE msgv1,
        a2 LIKE msgv1,
        a3 LIKE msgv1,
        a4 LIKE msgv1,
      END OF ls_msg.

    IF iv_location IS INITIAL.
      ls_msg = iv_msg.
    ELSE.
      lv_tmp = iv_msg && | @{ iv_location }|.
      ls_msg = lv_tmp.
    ENDIF.

    RAISE EXCEPTION TYPE zcx_abapgit_ajson_error
      EXPORTING
        textid = zcx_abapgit_ajson_error
        message = iv_msg
        msgv1  = ls_msg-a1
        msgv2  = ls_msg-a2
        msgv3  = ls_msg-a3
        msgv4  = ls_msg-a4.

  ENDMETHOD.