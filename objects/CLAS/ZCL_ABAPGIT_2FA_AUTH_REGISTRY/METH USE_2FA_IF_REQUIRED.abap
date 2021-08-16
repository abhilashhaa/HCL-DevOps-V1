  METHOD use_2fa_if_required.
    DATA: li_authenticator TYPE REF TO zif_abapgit_2fa_authenticator,
          lv_2fa_token     TYPE string,
          lv_access_token  TYPE string,
          lx_ex            TYPE REF TO cx_root.

    IF is_url_supported( iv_url ) = abap_false.
      RETURN.
    ENDIF.

    TRY.
        li_authenticator = get_authenticator_for_url( iv_url ).
        li_authenticator->begin( ).

        " Is two factor authentication required for this account?
        IF li_authenticator->is_2fa_required( iv_url      = iv_url
                                              iv_username = cv_username
                                              iv_password = cv_password ) = abap_true.

          lv_2fa_token = popup_token( ).

          " Delete an old access token if it exists
          li_authenticator->delete_access_tokens( iv_url       = iv_url
                                                  iv_username  = cv_username
                                                  iv_password  = cv_password
                                                  iv_2fa_token = lv_2fa_token ).

          " Get a new access token
          lv_access_token = li_authenticator->authenticate( iv_url       = iv_url
                                                            iv_username  = cv_username
                                                            iv_password  = cv_password
                                                            iv_2fa_token = lv_2fa_token ).

          " Use the access token instead of the password
          cv_password = lv_access_token.
        ENDIF.

        li_authenticator->end( ).

      CATCH zcx_abapgit_2fa_error INTO lx_ex.
        TRY.
            li_authenticator->end( ).
          CATCH zcx_abapgit_2fa_illegal_state ##NO_HANDLER.
        ENDTRY.

        zcx_abapgit_exception=>raise( |2FA error: { lx_ex->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.