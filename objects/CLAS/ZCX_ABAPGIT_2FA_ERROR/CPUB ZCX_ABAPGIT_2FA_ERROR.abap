class ZCX_ABAPGIT_2FA_ERROR definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  data MV_TEXT type STRING read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !MV_TEXT type STRING optional .

  methods IF_MESSAGE~GET_TEXT
    redefinition .