class ZCX_ABAPGIT_2FA_AUTH_FAILED definition
  public
  inheriting from ZCX_ABAPGIT_2FA_ERROR
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !MV_TEXT type STRING optional .