CLASS zcl_abapgit_time DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_unixtime TYPE c LENGTH 16.

    CLASS-METHODS get_unix
      IMPORTING iv_date        TYPE sy-datum DEFAULT sy-datum
                iv_time        TYPE sy-uzeit DEFAULT sy-uzeit
      RETURNING VALUE(rv_time) TYPE ty_unixtime
      RAISING   zcx_abapgit_exception.
    CLASS-METHODS get_utc
      IMPORTING iv_unix TYPE ty_unixtime
      EXPORTING ev_date TYPE sy-datum
                ev_time TYPE sy-uzeit.