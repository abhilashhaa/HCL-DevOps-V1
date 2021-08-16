"! Static registry class to find {@link ZIF_ABAPGIT_2FA_AUTHENTICATOR} instances
CLASS zcl_abapgit_2fa_auth_registry DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor,
      "! Retrieve an authenticator instance by url
      "! @parameter iv_url | Url of the repository / service
      "! @parameter ri_authenticator | Found authenticator instance
      "! @raising zcx_abapgit_2fa_unsupported | No authenticator found that supports the service
      get_authenticator_for_url IMPORTING iv_url                  TYPE string
                                RETURNING VALUE(ri_authenticator) TYPE REF TO zif_abapgit_2fa_authenticator
                                RAISING   zcx_abapgit_2fa_unsupported,
      "! Check if there is a two factor authenticator available for the url
      "! @parameter iv_url | Url of the repository / service
      "! @parameter rv_supported | 2FA is supported
      is_url_supported IMPORTING iv_url              TYPE string
                       RETURNING VALUE(rv_supported) TYPE abap_bool,
      "! Offer to use two factor authentication if supported and required
      "! <p>
      "! This uses GUI functionality to display a popup to request the user to enter a two factor
      "! token. Also an dummy authentication request might be used to find out if two factor
      "! authentication is required for the account.
      "! </p>
      "! @parameter iv_url | Url of the repository / service
      "! @parameter cv_username | Username
      "! @parameter cv_password | Password, will be replaced by an access token if two factor
      "!                          authentication succeeds
      "! @raising zcx_abapgit_exception | Error in two factor authentication
      use_2fa_if_required IMPORTING iv_url      TYPE string
                          CHANGING  cv_username TYPE string
                                    cv_password TYPE string
                          RAISING   zcx_abapgit_exception.
