*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

TYPES:
  tt_atnam_source TYPE STANDARD TABLE OF tcl_atinn_ident .
TYPES:
  tt_class_source TYPE STANDARD TABLE OF tcl_clint_ident .

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
  CLASS-METHODS /sapapo/cif_claf_inb
    IMPORTING
      VALUE(iv_rfc_dest)          TYPE rfcdest
      VALUE(is_control_parameter) TYPE /sapapo/cif_ctrlparam OPTIONAL
      VALUE(iv_logsrcsys)         TYPE /sapapo/cif_ctrlparam-logsrcsys OPTIONAL
    CHANGING
      ct_kssk                     TYPE tt_kssk OPTIONAL
      ct_inob                     TYPE tt_inob OPTIONAL
      ct_ausp                     TYPE tt_ausp OPTIONAL
      ct_allocation               TYPE tt_allocation OPTIONAL
      ct_value                    TYPE tt_value OPTIONAL
      ct_delob                    TYPE tt_delob OPTIONAL
      ct_extensionin              TYPE tt_extensionin OPTIONAL
      ct_atnam_source             TYPE tt_atnam_source OPTIONAL
      ct_class_source             TYPE tt_class_source OPTIONAL
*     ct_matcfgs                  TYPE tt_matcfgs OPTIONAL
      ct_return                   TYPE bapirettab.
ENDINTERFACE.

INTERFACE lif_db_access.
  CLASS-METHODS get_clf_data
    IMPORTING
      iv_class_type   TYPE klassenart
      iv_object_table TYPE tabelle
      iv_object_key   TYPE cuobn
    EXPORTING
      et_inob         TYPE tt_inob
      et_kssk         TYPE tt_kssk
      et_ausp         TYPE tt_ausp.
  CLASS-METHODS clse_select_cabn
    IMPORTING
      VALUE(key_date)                     TYPE valid_at DEFAULT sy-datum
      VALUE(bypassing_buffer)             TYPE sy-batch DEFAULT space
      VALUE(with_prepared_pattern)        TYPE sy-batch DEFAULT space
    EXPORTING
      VALUE(ambiguous_obj_characteristic) TYPE sy-batch
      ev_subrc                            TYPE sy-subrc
    CHANGING
      in_cabn                             TYPE tt_atinn_range
      t_cabn                              TYPE tt_cabn.
  CLASS-METHODS clcv_convert_object_to_fields
    IMPORTING
      iv_table     TYPE tabelle
    CHANGING
      cs_rmclfstru TYPE rmclf
      ev_subrc     TYPE sy-subrc .
ENDINTERFACE.