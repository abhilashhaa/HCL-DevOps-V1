*----------------------------------------------------------------------*
* This helper class is used to set and restore the current language.
* As some of the SAP functions used rely on SY-LANGU containing the
* master language, this class is used to temporarily change and then
* restore the value of SY-LANGU.
*----------------------------------------------------------------------*
CLASS zcl_abapgit_language DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS class_constructor .
    CLASS-METHODS restore_login_language .
    CLASS-METHODS set_current_language
      IMPORTING
        !iv_language TYPE langu .