*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_ngc_core_clf_ecn_bo DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: lif_ngc_core_clf_ecn_bo.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_ngc_core_clf_ecn_bo IMPLEMENTATION.
  METHOD lif_ngc_core_clf_ecn_bo~get_ecn.
    DATA: lo_ecn_bo TYPE REF TO /plmi/cl_ecn_bo.
    CLEAR: es_ecn, et_message, ev_severity.
    /plmi/cl_ecn_bo=>get_instance(
      IMPORTING
        eo_bo = lo_ecn_bo
    ).
    lo_ecn_bo->get_ecn(
      EXPORTING
        iv_change_no     = iv_change_no
        iv_refresh       = iv_refresh
        iv_lock_flag     = iv_lock_flag
        iv_include_saved = iv_include_saved
      IMPORTING
        es_ecn           = es_ecn
        et_message       = et_message
        ev_severity      = ev_severity
    ).
  ENDMETHOD.
ENDCLASS.