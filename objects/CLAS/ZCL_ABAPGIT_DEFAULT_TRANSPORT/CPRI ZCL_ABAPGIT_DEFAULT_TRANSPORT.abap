  PRIVATE SECTION.

    CLASS-DATA go_instance TYPE REF TO zcl_abapgit_default_transport .
    DATA mv_is_set_by_abapgit TYPE abap_bool .
    DATA ms_save TYPE e070use .

    METHODS store
      RAISING
        zcx_abapgit_exception .
    METHODS restore
      RAISING
        zcx_abapgit_exception .
    METHODS set_internal
      IMPORTING
        !iv_transport TYPE trkorr
      RAISING
        zcx_abapgit_exception .
    METHODS clear
      IMPORTING
        !is_default_task TYPE e070use
      RAISING
        zcx_abapgit_exception .