*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

INTERFACE lif_ngc_core_clf_ecn_bo.
  METHODS get_ecn
    IMPORTING
      !iv_change_no     TYPE aennr
      !iv_refresh       TYPE boole_d OPTIONAL
      !iv_lock_flag     TYPE boole_d OPTIONAL
      !iv_include_saved TYPE boole_d OPTIONAL
    EXPORTING
      !es_ecn           TYPE /plmi/s_ecn
      !et_message       TYPE /plmb/t_spi_msg
      !ev_severity      TYPE /plmb/spi_msg_severity .
ENDINTERFACE.