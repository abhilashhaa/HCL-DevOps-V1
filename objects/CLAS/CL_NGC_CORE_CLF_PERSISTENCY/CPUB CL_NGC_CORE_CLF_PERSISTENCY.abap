CLASS cl_ngc_core_clf_persistency DEFINITION
  PUBLIC
  CREATE PUBLIC

  GLOBAL FRIENDS tc_ngc_core_clf_persistency
                 th_ngc_core_clf_pers_data .

  PUBLIC SECTION.

    INTERFACES if_ngc_core_clf_persistency .

    TYPES:
      BEGIN OF lty_s_objectclass .
          INCLUDE TYPE: i_clfnobjectclassforkeydate AS objectclass.
      TYPES: class         TYPE i_clfnclassforkeydate-class.
    TYPES: key_date      TYPE dats.
    TYPES: END OF lty_s_objectclass .
    TYPES:
      lty_t_rmcldel TYPE STANDARD TABLE OF rmcldel WITH DEFAULT KEY .
    TYPES:
      lty_t_rinob TYPE STANDARD TABLE OF rinob WITH DEFAULT KEY .
    TYPES:
      lty_t_clmdcp TYPE STANDARD TABLE OF clmdcp .

    METHODS constructor
      IMPORTING
        !io_util            TYPE REF TO if_ngc_core_clf_util
        !io_db_update       TYPE REF TO if_ngc_core_clf_db_update
        !io_locking         TYPE REF TO if_ngc_core_clf_locking
        !io_bte             TYPE REF TO if_ngc_core_clf_bte
        !io_cls_persistency TYPE REF TO if_ngc_core_cls_persistency .