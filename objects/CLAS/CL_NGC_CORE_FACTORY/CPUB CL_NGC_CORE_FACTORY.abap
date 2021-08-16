CLASS cl_ngc_core_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS th_ngc_core_factory_inj.

  PUBLIC SECTION.

    CLASS-METHODS get_clf_persistency
      RETURNING
        VALUE(ro_clf_persistency) TYPE REF TO if_ngc_core_clf_persistency .
    CLASS-METHODS get_new_clf_persistency
      RETURNING
        VALUE(ro_clf_persistency) TYPE REF TO if_ngc_core_clf_persistency .
    CLASS-METHODS get_cls_persistency
      RETURNING
        VALUE(ro_cls_persistency) TYPE REF TO if_ngc_core_cls_persistency .
    CLASS-METHODS get_new_cls_persistency
      RETURNING
        VALUE(ro_cls_persistency) TYPE REF TO if_ngc_core_cls_persistency .
    CLASS-METHODS get_chr_persistency
      RETURNING
        VALUE(ro_chr_persistency) TYPE REF TO if_ngc_core_chr_persistency .
    CLASS-METHODS get_new_chr_persistency
      RETURNING
        VALUE(ro_chr_persistency) TYPE REF TO if_ngc_core_chr_persistency .