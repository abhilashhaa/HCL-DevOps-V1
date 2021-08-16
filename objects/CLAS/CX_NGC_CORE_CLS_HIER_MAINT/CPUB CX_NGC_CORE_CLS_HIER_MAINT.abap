class CX_NGC_CORE_CLS_HIER_MAINT definition
  public
  inheriting from CX_NO_CHECK
  final
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of UNKNOWN_ERROR,
      msgid type symsgid value 'NGC_CORE_CLS',
      msgno type symsgno value '000',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of UNKNOWN_ERROR .
  constants:
    begin of NOT_FIND_RELATION,
      msgid type symsgid value 'NGC_CORE_CLS',
      msgno type symsgno value '002',
      attr1 type scx_attrname value 'NODE',
      attr2 type scx_attrname value 'ANCESTOR',
      attr3 type scx_attrname value 'VALID_FROM',
      attr4 type scx_attrname value '',
    end of NOT_FIND_RELATION .
  constants:
    begin of INVALID_DATE_INTERVAL,
      msgid type symsgid value 'NGC_CORE_CLS',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'VALID_FROM',
      attr2 type scx_attrname value 'VALID_TO',
      attr3 type scx_attrname value 'TABLE_NAME',
      attr4 type scx_attrname value '',
    end of INVALID_DATE_INTERVAL .
  data ANCESTOR type CLINT .
  data NODE type CLINT .
  data VALID_FROM type DATS .
  data VALID_TO type DATS .
  data TABLE_NAME type CHAR30 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !ANCESTOR type CLINT optional
      !NODE type CLINT optional
      !VALID_FROM type DATS optional
      !VALID_TO type DATS optional
      !TABLE_NAME type CHAR30 optional .