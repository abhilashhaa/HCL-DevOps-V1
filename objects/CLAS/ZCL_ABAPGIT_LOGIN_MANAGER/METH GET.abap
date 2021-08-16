  METHOD get.

    DATA ls_auth LIKE LINE OF gt_auth.

    READ TABLE gt_auth INTO ls_auth WITH KEY uri = zcl_abapgit_url=>host( iv_uri ).
    IF sy-subrc = 0.
      rv_auth = ls_auth-authorization.
    ENDIF.

  ENDMETHOD.