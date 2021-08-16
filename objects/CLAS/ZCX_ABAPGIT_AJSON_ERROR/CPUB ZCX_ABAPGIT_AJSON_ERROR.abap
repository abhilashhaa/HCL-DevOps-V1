class ZCX_ABAPGIT_AJSON_ERROR definition
  public
  inheriting from ZCX_ABAPGIT_EXCEPTION
  final
  create public .

public section.

  constants:
    begin of ZCX_ABAPGIT_AJSON_ERROR,
      msgid type symsgid value '00',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'MSGV1',
      attr2 type scx_attrname value 'MSGV2',
      attr3 type scx_attrname value 'MSGV3',
      attr4 type scx_attrname value 'MSGV4',
    end of ZCX_ABAPGIT_AJSON_ERROR .
  data MESSAGE type STRING read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MSGV1 type SYMSGV optional
      !MSGV2 type SYMSGV optional
      !MSGV3 type SYMSGV optional
      !MSGV4 type SYMSGV optional
      !MESSAGE type STRING optional .
  class-methods RAISE_JSON
    importing
      !IV_MSG type STRING
      !IV_LOCATION type STRING optional
    raising
      ZCX_ABAPGIT_AJSON_ERROR .