*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

INTERFACE lif_selection_util.

  CLASS-METHODS free_selections_range_2_where
    IMPORTING
      VALUE(field_ranges)  TYPE rsds_trange
    EXPORTING
      VALUE(where_clauses) TYPE rsds_twhere.

ENDINTERFACE.

INTERFACE lif_db_access.
  TYPES:
    tt_clatnamrange TYPE STANDARD TABLE OF clatnamrange,
    tt_clsichtrange TYPE STANDARD TABLE OF clsichtrange.
  CLASS-METHODS clidl_read_masterdata
    IMPORTING
      VALUE(with_hierarchies) TYPE  flag OPTIONAL
      it_atinn_range          TYPE tt_atinn_range OPTIONAL
      it_atnam_range          TYPE tt_clatnamrange OPTIONAL
      it_klart_range          TYPE tt_klart_range OPTIONAL
      it_class_range          TYPE tt_class_range OPTIONAL
      it_clint_range          TYPE tt_clint_range OPTIONAL
      it_sicht_range          TYPE tt_clsichtrange OPTIONAL
    EXPORTING
      VALUE(source_system)    TYPE logsys
      et_atinn_range          TYPE tt_atinn_range
      et_cabn                 TYPE tt_cabn
      et_cabnt                TYPE tt_cabnt
      et_cawn                 TYPE tt_cawn
      et_cawnt                TYPE tt_cawnt
      et_cabnz                TYPE tt_cabnz
      et_tcme                 TYPE tt_tcme
      et_klah                 TYPE tt_klah
      et_swor                 TYPE tt_swor
      et_ksml                 TYPE tt_ksml
      ev_subrc                TYPE sy-subrc .
  CLASS-METHODS number_get_next
    IMPORTING
      VALUE(nr_range_nr)   TYPE inri-nrrangenr
      VALUE(object)        TYPE inri-object
      VALUE(quantity)      TYPE inri-quantity DEFAULT '1'
      VALUE(subobject)     TYPE nrsobj DEFAULT space
      VALUE(toyear)        TYPE inri-toyear DEFAULT '0000'
      VALUE(ignore_buffer) TYPE boole_d DEFAULT space
    EXPORTING
      VALUE(number)        TYPE nrlevel
      VALUE(ev_quantity)   TYPE inri-quantity
      VALUE(returncode)    TYPE inri-returncode
      ev_subrc             TYPE sy-subrc .
ENDINTERFACE.