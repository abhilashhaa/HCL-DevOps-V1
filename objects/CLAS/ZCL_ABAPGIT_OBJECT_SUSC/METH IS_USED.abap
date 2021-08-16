  METHOD is_used.

    DATA: lv_used_auth_object_class TYPE tobc-oclss.

    SELECT SINGLE oclss
      FROM tobj
      INTO lv_used_auth_object_class
      WHERE oclss = iv_auth_object_class ##WARN_OK.
    IF sy-subrc = 0.
      zcx_abapgit_exception=>raise_t100( iv_msgid = '01'
                                         iv_msgno = '212'
                                         iv_msgv1 = |{ iv_auth_object_class }| ).
    ENDIF.

  ENDMETHOD.