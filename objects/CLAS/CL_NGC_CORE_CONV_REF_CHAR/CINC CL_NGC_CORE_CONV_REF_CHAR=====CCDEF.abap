*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

CLASS lcl_refval_reader_general DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    METHODS:
      constructor
        IMPORTING
          iv_language           TYPE sy-langu
          iv_in_range_limit     TYPE i,
      get_reader_id
        RETURNING
          VALUE(rv_reader_id)   TYPE string,
      get_obtab_filter
        RETURNING
          VALUE(rt_sel_obtab)   TYPE REF TO cl_ngc_core_conv_ref_char=>ltr_obtab,
      get_change_of_date_supported
        RETURNING
          VALUE(rv_supported)   TYPE boole_d,
      read_objects
        IMPORTING
          it_refbou             TYPE cl_ngc_core_conv_ref_char=>ltt_refbou,
      read_ref_values
        IMPORTING
          iv_obtab              TYPE tabelle
          iv_objek              TYPE cuobn
        EXPORTING
          et_attabs             TYPE cl_ngc_core_conv_ref_char=>ltt_attabs
          ev_should_exit        TYPE boole_d
        CHANGING
          ct_refvals            TYPE cl_ngc_core_conv_ref_char=>ltt_refvalidity
          ct_events             TYPE cl_ngc_core_conv_ref_char=>ltt_event_count,
      refval_to_ausp
        IMPORTING
          is_refval             TYPE cl_ngc_core_conv_ref_char=>lts_refvalidity
          is_attab              TYPE cl_ngc_core_conv_ref_char=>lts_refbou
        EXPORTING
          es_ausp               TYPE ausp
          ev_value_exists       TYPE abap_bool
        CHANGING
          ct_events             TYPE cl_ngc_core_conv_ref_char=>ltt_event_count,
      add_package_end_msgs
        CHANGING
          ct_events             TYPE cl_ngc_core_conv_ref_char=>ltt_event_count.
  PROTECTED SECTION.
    TYPES:
      begin of lts_object_check_name,
        obtab                   TYPE tabelle,
        fkbname                 TYPE rs38l_fnam,
      end of lts_object_check_name,
      ltt_object_check_names    TYPE HASHED TABLE OF lts_object_check_name WITH UNIQUE KEY obtab.
    CONSTANTS:
      gc_atfor_char             TYPE atfor VALUE 'CHAR' ##NO_TEXT,
      gc_no_name                TYPE rs38l_fnam VALUE '-' ##NO_TEXT.
    DATA:
      mv_language               TYPE sy-langu,
      mv_in_range_limit         TYPE i,
      mt_object_check_names     TYPE ltt_object_check_names.
    METHODS:
      get_objchk_name
        IMPORTING
          iv_obtab              TYPE tabelle
        RETURNING
          VALUE(rv_objchk_name) TYPE rs38l_fnam,
      extract_refvalue
        IMPORTING
          is_refval             TYPE cl_ngc_core_conv_ref_char=>lts_refvalidity
          is_attab              TYPE cl_ngc_core_conv_ref_char=>lts_refbou
        CHANGING
          cr_refvalue           TYPE REF TO data
        RETURNING
          VALUE(rv_success)     TYPE boole_d
        RAISING
          cx_data_conv_error,
      create_ausp_row
        IMPORTING
          ir_refvalue           TYPE REF TO data
          iv_objek              TYPE cuobn
          iv_klart              TYPE klassenart
          iv_atinn              TYPE atinn
          iv_aennr              TYPE aennr
          iv_datuv              TYPE datuv
          iv_atfor              TYPE atfor
          iv_atkon              TYPE atkon
          iv_msehi              TYPE msehi
          iv_anzdz              TYPE anzdz
        EXPORTING
          es_ausp               TYPE ausp
        RAISING
          cx_data_conv_error .
ENDCLASS.

CLASS lcl_refval_reader_mara DEFINITION INHERITING FROM lcl_refval_reader_general ##CLASS_FINAL.
  PUBLIC SECTION.
    METHODS:
      get_reader_id REDEFINITION,
      get_obtab_filter REDEFINITION,
      get_change_of_date_supported REDEFINITION,
      read_objects REDEFINITION,
      read_ref_values REDEFINITION,
      add_package_end_msgs REDEFINITION.
  PROTECTED SECTION.
    DATA:
      mt_mara       TYPE HASHED TABLE OF mara WITH UNIQUE KEY matnr,
      mt_makt       TYPE HASHED TABLE OF makt WITH UNIQUE KEY matnr spras,
      mr_mara       TYPE REF TO mara,
      ms_makt_empty TYPE makt.
    METHODS:
      extract_refvalue REDEFINITION.
ENDCLASS.

CLASS lcl_refval_reader_mcha DEFINITION INHERITING FROM lcl_refval_reader_general ##CLASS_FINAL.
  PUBLIC SECTION.
    METHODS:
      get_reader_id REDEFINITION,
      get_obtab_filter REDEFINITION,
      get_change_of_date_supported REDEFINITION,
      read_objects REDEFINITION,
      read_ref_values REDEFINITION,
      add_package_end_msgs REDEFINITION.
  PROTECTED SECTION.
    TYPES:
      BEGIN OF lts_mchakey,
        matnr  TYPE mcha-matnr,
        werks  TYPE mcha-werks,
        charg  TYPE mcha-charg,
      END   OF lts_mchakey.
    DATA:
      mt_mara       TYPE HASHED TABLE OF mara WITH UNIQUE KEY matnr,
      mt_makt       TYPE HASHED TABLE OF makt WITH UNIQUE KEY matnr spras,
      mt_mcha       TYPE HASHED TABLE OF mcha WITH UNIQUE KEY matnr werks charg,
      mr_mcha       TYPE REF TO mcha,
      ms_mara_empty TYPE mara,
      ms_makt_empty TYPE makt.
    METHODS:
      extract_refvalue REDEFINITION.
ENDCLASS.


CLASS lcl_refval_reader_mch1 DEFINITION INHERITING FROM lcl_refval_reader_general ##CLASS_FINAL.
  PUBLIC SECTION.
    METHODS:
      get_reader_id REDEFINITION,
      get_obtab_filter REDEFINITION,
      get_change_of_date_supported REDEFINITION,
      read_objects REDEFINITION,
      read_ref_values REDEFINITION,
      add_package_end_msgs REDEFINITION.
  PROTECTED SECTION.
    TYPES:
      BEGIN OF lts_mch1key,
        matnr  TYPE mch1-matnr,
        charg  TYPE mch1-charg,
      END   OF lts_mch1key.
    DATA:
      mt_mara       TYPE HASHED TABLE OF mara WITH UNIQUE KEY matnr,
      mt_makt       TYPE HASHED TABLE OF makt WITH UNIQUE KEY matnr spras,
      mt_mch1       TYPE HASHED TABLE OF mch1 WITH UNIQUE KEY matnr charg,
      mr_mch1       TYPE REF TO mch1,
      ms_mara_empty TYPE mara,
      ms_makt_empty TYPE makt.
    METHODS:
      extract_refvalue REDEFINITION.
ENDCLASS.


CLASS lcl_refval_reader_draw DEFINITION INHERITING FROM lcl_refval_reader_general ##CLASS_FINAL.
  PUBLIC SECTION.
    METHODS:
      get_reader_id REDEFINITION,
      get_obtab_filter REDEFINITION,
      get_change_of_date_supported REDEFINITION,
      read_objects REDEFINITION,
      read_ref_values REDEFINITION,
      add_package_end_msgs REDEFINITION.
  PROTECTED SECTION.
    DATA:
      mt_draw       TYPE HASHED TABLE OF draw WITH UNIQUE KEY dokar doknr dokvr doktl,
      mt_drat       TYPE HASHED TABLE OF drat WITH UNIQUE KEY dokar doknr dokvr doktl langu
             WITH NON-UNIQUE SORTED KEY dratseckey COMPONENTS dokar doknr dokvr doktl,
      mr_draw       TYPE REF TO draw,
      ms_drat_empty TYPE drat.
    METHODS:
      extract_refvalue REDEFINITION.
ENDCLASS.