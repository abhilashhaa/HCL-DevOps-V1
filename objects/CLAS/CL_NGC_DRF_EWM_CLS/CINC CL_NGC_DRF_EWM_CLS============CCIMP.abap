*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_cif_functions DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_cif_functions.
ENDCLASS.

CLASS lcl_cif_functions IMPLEMENTATION.
  METHOD lif_cif_functions~/sapapo/cif_cla30_inb.
    CALL FUNCTION '/SAPAPO/CIF_CLA30_INB'
      IN BACKGROUND TASK DESTINATION iv_rfc_dest
      EXPORTING
        is_control_parameter = is_control_parameter
        iv_logsrcsys         = iv_logsrcsys
      TABLES
        it_klah              = ct_klah
        it_swor              = ct_swor
        it_ksml              = ct_ksml
        it_class_match       = ct_class_match
        et_return            = ct_return
        it_extensionin       = ct_extensionin
      EXCEPTIONS
        init_error           = 1
        logsys_error         = 2
        bsg_error            = 3
        userexit_error       = 4
        odb_error            = 5
        posting_error        = 6
        logging_error        = 7
        internal_error       = 8
        OTHERS               = 9.
    ev_subrc = sy-subrc.
  ENDMETHOD.
  METHOD lif_cif_functions~/sapapo/cif_claf_inb.
    CLEAR: ct_return.

    CALL FUNCTION '/SAPAPO/CIF_CLAF_INB'
      IN BACKGROUND TASK DESTINATION iv_rfc_dest
      EXPORTING
        is_control_parameter = is_control_parameter
      TABLES
        it_kssk              = ct_kssk
        it_inob              = ct_inob
        it_ausp              = ct_ausp
        it_allocation        = ct_allocation
        it_value             = ct_value
        it_delob             = ct_delob
        it_extensionin       = ct_extensionin
*       it_atnam_source      = ct_atnam_source
*       it_class_source      = ct_class_source
*       it_matcfgs           = ct_matcfgs
        et_return            = ct_return.
  ENDMETHOD.
ENDCLASS.