*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
INTERFACE lif_drf_access_cust_data.

  CLASS-METHODS select_business_sys_for_appl
    IMPORTING
      !iv_appl          TYPE drf_appl
      !iv_outb_impl     TYPE drf_outb_impl OPTIONAL
      !iv_bypass_buffer TYPE abap_bool DEFAULT ' '
    EXPORTING
      !et_bus_sys_tech  TYPE mdg_t_bus_sys_tech
      !et_bus_sys_appl  TYPE drf_to_appl_sys
      !et_bus_sys       TYPE mdg_t_bus_sys .

ENDINTERFACE.

INTERFACE lif_drf_ale_info.

  CLASS-METHODS determine_message_type
    IMPORTING
      !iv_mestyp        TYPE refmestyp
      !iv_target_system TYPE logsys
    EXPORTING
      !ev_mestyp        TYPE edi_mestyp
      !et_mestyp        TYPE drf_t_edi_mestyp
      !es_message       TYPE bal_s_msg .

ENDINTERFACE.

INTERFACE lif_idoc_functions.

  CLASS-METHODS masteridoc_create_clfmas
    IMPORTING
      VALUE(object)                 TYPE kssk-objek
      VALUE(class_type)             TYPE kssk-klart
      VALUE(type_of_classification) TYPE kssk-mafid
      VALUE(key_date)               TYPE sy-datum DEFAULT sy-datum
      VALUE(change_number)          TYPE cabn-aennr OPTIONAL
      VALUE(rcvpfc)                 TYPE bdaledc-rcvpfc
      VALUE(rcvprn)                 TYPE bdaledc-rcvprn
      VALUE(rcvprt)                 TYPE bdaledc-rcvprt
      VALUE(sndpfc)                 TYPE bdaledc-sndpfc
      VALUE(sndprn)                 TYPE bdaledc-sndprn
      VALUE(sndprt)                 TYPE bdaledc-sndprt
      VALUE(message_type)           TYPE tbdme-mestyp
      VALUE(dlock_ignore)           TYPE xfeld DEFAULT space
      VALUE(mescod)                 TYPE edidc-mescod DEFAULT '   '
    EXPORTING
      VALUE(created_comm_idocs)     TYPE sy-tabix
    CHANGING
      te_idoc_control               TYPE edidc_tt OPTIONAL
      it_clint_range                TYPE tt_clint_range OPTIONAL.

ENDINTERFACE.