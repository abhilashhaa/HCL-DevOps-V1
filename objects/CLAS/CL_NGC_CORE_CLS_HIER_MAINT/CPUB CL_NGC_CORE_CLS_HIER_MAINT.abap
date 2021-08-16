class CL_NGC_CORE_CLS_HIER_MAINT definition
  public
  create public .

public section.

  interfaces IF_NGC_CORE_CLS_HIER_MAINT .

  constants GC_TABLE_KLAH type CHAR30 value 'KLAH' ##NO_TEXT.
  constants GC_TABLE_KSSK type CHAR30 value 'KSSK' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IO_DB_ACCESS type ref to IF_NGC_CORE_CLS_HIER_DBACCESS .