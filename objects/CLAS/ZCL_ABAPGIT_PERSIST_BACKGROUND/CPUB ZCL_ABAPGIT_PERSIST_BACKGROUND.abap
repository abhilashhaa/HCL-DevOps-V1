CLASS zcl_abapgit_persist_background DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_xml,
             method   TYPE string,
             username TYPE string,
             password TYPE string,
             settings TYPE zif_abapgit_background=>ty_settings_tt,
           END OF ty_xml.

    TYPES: BEGIN OF ty_background,
             key TYPE zif_abapgit_persistence=>ty_value.
        INCLUDE TYPE ty_xml.
    TYPES: END OF ty_background.
    TYPES: tt_background TYPE STANDARD TABLE OF ty_background WITH DEFAULT KEY.

    METHODS constructor.

    METHODS list
      RETURNING VALUE(rt_list) TYPE tt_background
      RAISING   zcx_abapgit_exception.

    METHODS modify
      IMPORTING is_data TYPE ty_background
      RAISING   zcx_abapgit_exception.

    METHODS delete
      IMPORTING iv_key TYPE ty_background-key
      RAISING   zcx_abapgit_exception.

    METHODS exists
      IMPORTING iv_key        TYPE ty_background-key
      RETURNING VALUE(rv_yes) TYPE abap_bool
      RAISING   zcx_abapgit_exception.