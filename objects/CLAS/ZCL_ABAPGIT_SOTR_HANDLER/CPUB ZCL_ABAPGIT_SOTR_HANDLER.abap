CLASS zcl_abapgit_sotr_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      ty_sotr_use_tt TYPE STANDARD TABLE OF sotr_use WITH DEFAULT KEY .

    CLASS-METHODS read_sotr
      IMPORTING
        !iv_pgmid    TYPE pgmid
        !iv_object   TYPE trobjtype
        !iv_obj_name TYPE csequence
        !io_xml      TYPE REF TO zif_abapgit_xml_output OPTIONAL
      EXPORTING
        !et_sotr     TYPE zif_abapgit_definitions=>ty_sotr_tt
        !et_sotr_use TYPE zif_abapgit_definitions=>ty_sotr_use_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS create_sotr
      IMPORTING
        !iv_package TYPE devclass
        !io_xml     TYPE REF TO zif_abapgit_xml_input
      RAISING
        zcx_abapgit_exception .