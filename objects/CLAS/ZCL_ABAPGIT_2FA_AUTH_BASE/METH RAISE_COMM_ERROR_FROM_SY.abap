  METHOD raise_comm_error_from_sy.
    DATA: lv_error_msg TYPE string.

    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
            INTO lv_error_msg.
    RAISE EXCEPTION TYPE zcx_abapgit_2fa_comm_error
      EXPORTING
        mv_text = |Communication error: { lv_error_msg }|.
  ENDMETHOD.