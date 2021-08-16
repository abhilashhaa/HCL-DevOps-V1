*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

INTERFACE lif_cif_functions.
  TYPES:
    tt_kssk        TYPE STANDARD TABLE OF /sapapo/cif_kssk_cbc,
    tt_inob        TYPE STANDARD TABLE OF /sapapo/cif_inob_cbc,
    tt_ausp        TYPE STANDARD TABLE OF /sapapo/cif_ausp_cbc,
    tt_allocation  TYPE STANDARD TABLE OF /sapapo/cif_rmclkssk_cbc,
    tt_value       TYPE STANDARD TABLE OF /sapapo/cif_rmclausp_cbc,
    tt_delob       TYPE STANDARD TABLE OF /sapapo/cif_rmcldob_cbc,
    tt_extensionin TYPE STANDARD TABLE OF /sapapo/cifbparex.
*   tt_atnam_source TYPE STANDARD TABLE OF tcl_atinn_ident,
*   tt_class_source TYPE STANDARD TABLE OF tcl_clint_ident,
*   tt_matcfgs      TYPE STANDARD TABLE OF /sapapo/cif_matcfgstab.
  CLASS-METHODS /sapapo/cif_cla30_inb
    IMPORTING
      VALUE(iv_rfc_dest)          TYPE rfcdest
      VALUE(is_control_parameter) TYPE /sapapo/cif_ctrlparam OPTIONAL
      VALUE(iv_logsrcsys)         TYPE /sapapo/cif_ctrlparam-logsrcsys OPTIONAL
    EXPORTING
      ev_subrc                    TYPE sy-subrc
    CHANGING
      ct_klah                     TYPE tt_klah
      ct_swor                     TYPE tt_swor
      ct_ksml                     TYPE tt_ksml
      ct_class_match              TYPE /sapapo/mc01_clintidnt_tabtype OPTIONAL
      ct_extensionin              TYPE /sapapo/cifbparex_tab OPTIONAL
      ct_return                   TYPE bapirettab.
  CLASS-METHODS /sapapo/cif_claf_inb
    IMPORTING
      VALUE(iv_rfc_dest)          TYPE rfcdest
      VALUE(is_control_parameter) TYPE /sapapo/cif_ctrlparam OPTIONAL
    CHANGING
      ct_kssk                     TYPE tt_kssk OPTIONAL
      ct_inob                     TYPE tt_inob OPTIONAL
      ct_ausp                     TYPE tt_ausp OPTIONAL
      ct_allocation               TYPE tt_allocation OPTIONAL
      ct_value                    TYPE tt_value OPTIONAL
      ct_delob                    TYPE tt_delob OPTIONAL
      ct_extensionin              TYPE tt_extensionin OPTIONAL
*     ct_atnam_source             TYPE tt_atnam_source OPTIONAL
*     ct_class_source             TYPE tt_class_source OPTIONAL
*     ct_matcfgs                  TYPE tt_matcfgs OPTIONAL
      ct_return                   TYPE bapirettab.
ENDINTERFACE.