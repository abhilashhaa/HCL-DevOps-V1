  METHOD append.

    FIELD-SYMBOLS: <ls_auth> LIKE LINE OF gt_auth.

    READ TABLE gt_auth WITH KEY uri = zcl_abapgit_url=>host( iv_uri )
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      APPEND INITIAL LINE TO gt_auth ASSIGNING <ls_auth>.
      <ls_auth>-uri           = zcl_abapgit_url=>host( iv_uri ).
      <ls_auth>-authorization = iv_auth.
    ENDIF.

  ENDMETHOD.