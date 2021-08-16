*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lcl_db_access DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_db_access.
ENDCLASS.

CLASS lcl_db_access IMPLEMENTATION.
  METHOD lif_db_access~clidl_read_masterdata.
    CLEAR: source_system, et_atinn_range, et_cabn,
           et_cabnt, et_cawn,
           et_cawnt, et_cabnz, et_tcme,
           et_klah, et_swor, et_ksml.

    CALL FUNCTION 'CLIDL_READ_MASTERDATA'
      EXPORTING
        with_hierarchies = with_hierarchies
      IMPORTING
        source_system    = source_system
      TABLES
        it_atinn_range   = it_atinn_range
        it_atnam_range   = it_atnam_range
        it_klart_range   = it_klart_range
        it_class_range   = it_class_range
        it_clint_range   = it_clint_range
        it_sicht_range   = it_sicht_range
        et_atinn_range   = et_atinn_range
        et_cabn          = et_cabn
        et_cabnt         = et_cabnt
        et_cawn          = et_cawn
        et_cawnt         = et_cawnt
        et_cabnz         = et_cabnz
        et_tcme          = et_tcme
        et_klah          = et_klah
        et_swor          = et_swor
        et_ksml          = et_ksml
      EXCEPTIONS
        authority_denied = 1
        OTHERS           = 2.
    ev_subrc = sy-subrc.
  ENDMETHOD.
  METHOD lif_db_access~number_get_next.
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = nr_range_nr
        object                  = object
        quantity                = quantity
        subobject               = subobject
        toyear                  = toyear
        ignore_buffer           = ignore_buffer
      IMPORTING
        number                  = number
        quantity                = ev_quantity
        returncode              = returncode
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    ev_subrc = sy-subrc.
  ENDMETHOD.
ENDCLASS.