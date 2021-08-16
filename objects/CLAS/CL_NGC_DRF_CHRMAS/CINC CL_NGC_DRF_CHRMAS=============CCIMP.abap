*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_drf_access_cust_data DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_drf_access_cust_data.
ENDCLASS.
CLASS lcl_drf_access_cust_data IMPLEMENTATION.
  METHOD lif_drf_access_cust_data~select_business_sys_for_appl.
    cl_drf_access_cust_data=>select_business_sys_for_appl(
      EXPORTING
        iv_appl          = iv_appl
        iv_outb_impl     = iv_outb_impl
        iv_bypass_buffer = iv_bypass_buffer
      IMPORTING
        et_bus_sys_tech  = et_bus_sys_tech
        et_bus_sys_appl  = et_bus_sys_appl
        et_bus_sys       = et_bus_sys
    ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_drf_ale_info DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_drf_ale_info.
ENDCLASS.
CLASS lcl_drf_ale_info IMPLEMENTATION.
  METHOD lif_drf_ale_info~determine_message_type.
    cl_drf_ale_info=>determine_message_type(
      EXPORTING
        iv_mestyp        = iv_mestyp
        iv_target_system = iv_target_system
      IMPORTING
        ev_mestyp        = ev_mestyp
        et_mestyp        = et_mestyp
        es_message       = es_message
    ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_idoc_functions DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_idoc_functions.
ENDCLASS.

CLASS lcl_idoc_functions IMPLEMENTATION.
  METHOD lif_idoc_functions~masteridoc_create_chrmas.
    CLEAR: created_comm_idocs.
    CALL FUNCTION 'MASTERIDOC_CREATE_CHRMAS'
      EXPORTING
        charact            = charact
        key_date           = key_date
        change_number      = change_number
        rcvpfc             = rcvpfc
        rcvprn             = rcvprn
        rcvprt             = rcvprt
        sndpfc             = sndpfc
        sndprn             = sndprn
        sndprt             = sndprt
        message_type       = message_type
        dlock_ignore       = dlock_ignore
        mescod             = mescod
      IMPORTING
        created_comm_idocs = created_comm_idocs
      TABLES
        te_idoc_control    = te_idoc_control.
  ENDMETHOD.
ENDCLASS.