"! Default {@link ZIF_ABAPGIT_2FA_AUTHENTICATOR} implementation
CLASS zcl_abapgit_2fa_auth_base DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_2fa_authenticator.
    ALIASES:
      authenticate FOR zif_abapgit_2fa_authenticator~authenticate,
      supports_url FOR zif_abapgit_2fa_authenticator~supports_url,
      is_2fa_required FOR zif_abapgit_2fa_authenticator~is_2fa_required,
      delete_access_tokens FOR zif_abapgit_2fa_authenticator~delete_access_tokens,
      begin FOR zif_abapgit_2fa_authenticator~begin,
      end FOR zif_abapgit_2fa_authenticator~end.
    METHODS:
      "! @parameter iv_supported_url_regex | Regular expression to check if a repository url is
      "!                                     supported, used for default implementation of
      "!                                     {@link .METH:supports_url}
      constructor IMPORTING iv_supported_url_regex TYPE clike.