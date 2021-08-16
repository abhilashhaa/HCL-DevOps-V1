*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

INTERFACE lif_db_access.
  CLASS-METHODS get_chr_data
    IMPORTING
      iv_characteristic_name TYPE atnam
      iv_change_number       TYPE aennr
    EXPORTING
      et_cabn                TYPE tt_cabn
      et_cabnt               TYPE tt_cabnt
      et_cawn                TYPE tt_cawn
      et_cawnt               TYPE tt_cawnt
      et_cabnz               TYPE tt_cabnz
      et_tcme                TYPE tt_tcme .
ENDINTERFACE.