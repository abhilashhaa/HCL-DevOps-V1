interface IF_NGC_BIL_CHR_C
  public .

  types:
    BEGIN OF lty_clfncharctp,
      t_create      TYPE TABLE FOR CREATE   i_clfncharcforkeydatetp,
      t_delete      TYPE TABLE FOR DELETE   i_clfncharcforkeydatetp,
      t_update      TYPE TABLE FOR UPDATE   i_clfncharcforkeydatetp,

      t_mapped      TYPE TABLE FOR MAPPED   i_clfncharcforkeydatetp,
      t_failed      TYPE TABLE FOR FAILED   i_clfncharcforkeydatetp,
      t_reported    TYPE TABLE FOR REPORTED i_clfncharcforkeydatetp,

      t_mapped_late TYPE TABLE FOR MAPPED LATE i_clfncharcforkeydatetp,

      t_read_in     TYPE TABLE FOR READ IMPORT i_clfncharcforkeydatetp,
      t_read_out    TYPE TABLE FOR READ RESULT i_clfncharcforkeydatetp,

*      t_delete_ecn  TYPE TABLE FOR ACTION IMPORT i_clfncharcforkeydatetp~deletecharcwithecn,

      s_create      TYPE LINE OF lty_clfncharctp-t_create,
      s_update      TYPE LINE OF lty_clfncharctp-t_update,
    END OF lty_clfncharctp .
  types:
    BEGIN OF lty_clfncharcdesctp,
      t_create        TYPE TABLE FOR CREATE   i_clfncharcforkeydatetp\_characteristicdesc,
      t_delete        TYPE TABLE FOR DELETE   i_clfncharcdescforkeydatetp,
      t_update        TYPE TABLE FOR UPDATE   i_clfncharcdescforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfncharcdescforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfncharcdescforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfncharcdescforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfncharcdescforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfncharcdescforkeydatetp,

      t_read_in       TYPE TABLE FOR READ IMPORT i_clfncharcdescforkeydatetp,
      t_read_out      TYPE TABLE FOR READ RESULT i_clfncharcdescforkeydatetp,
    END OF lty_clfncharcdesctp .
  types:
    BEGIN OF lty_clfncharcrstrcntp,
      t_create        TYPE TABLE FOR CREATE   i_clfncharcforkeydatetp\_characteristicrestriction,
      t_delete        TYPE TABLE FOR DELETE   i_clfncharcrstrcnforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfncharcrstrcnforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfncharcrstrcnforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfncharcrstrcnforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfncharcrstrcnforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfncharcrstrcnforkeydatetp,

      t_read_in       TYPE TABLE FOR READ IMPORT i_clfncharcrstrcnforkeydatetp,
      t_read_out      TYPE TABLE FOR READ RESULT i_clfncharcrstrcnforkeydatetp,
    END OF lty_clfncharcrstrcntp .
  types:
    BEGIN OF lty_clfncharcreftp,
      t_create        TYPE TABLE FOR CREATE   i_clfncharcforkeydatetp\_characteristicreference,
      t_delete        TYPE TABLE FOR DELETE   i_clfncharcrefforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfncharcrefforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfncharcrefforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfncharcrefforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfncharcrefforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfncharcrefforkeydatetp,

      t_read_in       TYPE TABLE FOR READ IMPORT i_clfncharcrefforkeydatetp,
      t_read_out      TYPE TABLE FOR READ RESULT i_clfncharcrefforkeydatetp,
    END OF lty_clfncharcreftp .
  types:
    BEGIN OF lty_clfncharcvaltp,
      t_create        TYPE TABLE FOR CREATE   i_clfncharcforkeydatetp\_characteristicvalue,
      t_delete        TYPE TABLE FOR DELETE   i_clfncharcvalforkeydatetp,
      t_update        TYPE TABLE FOR UPDATE   i_clfncharcvalforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfncharcvalforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfncharcvalforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfncharcvalforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfncharcvalforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfncharcvalforkeydatetp,

      t_read_in       TYPE TABLE FOR READ IMPORT i_clfncharcvalforkeydatetp,
      t_read_out      TYPE TABLE FOR READ RESULT i_clfncharcvalforkeydatetp,

      s_update        TYPE LINE OF lty_clfncharcvaltp-t_update,
    END OF lty_clfncharcvaltp .
  types:
    BEGIN OF lty_clfncharcvaldesctp,
      t_create        TYPE TABLE FOR CREATE   i_clfncharcvalforkeydatetp\_charcvaluedesc,
      t_delete        TYPE TABLE FOR DELETE   i_clfncharcvaldescforkeydatetp,
      t_update        TYPE TABLE FOR UPDATE   i_clfncharcvaldescforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfncharcvaldescforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfncharcvaldescforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfncharcvaldescforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfncharcvaldescforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfncharcvaldescforkeydatetp,

      t_read_in       TYPE TABLE FOR READ IMPORT i_clfncharcvaldescforkeydatetp,
      t_read_out      TYPE TABLE FOR READ RESULT i_clfncharcvaldescforkeydatetp,
    END OF lty_clfncharcvaldesctp .

  constants:
    BEGIN OF gcs_vdm_entity_tp,
      characteristic TYPE string VALUE 'i_clfncharcforkeydatetp',
      charc_desc     TYPE string VALUE 'i_clfncharcdescforkeydatetp',
      charc_rstr     TYPE string VALUE 'i_clfncharcrstrcnforkeydatetp',
      charc_ref      TYPE string VALUE 'i_clfncharcrefforkeydatetp',
      charc_val      TYPE string VALUE 'i_clfncharcvalforkeydatetp',
      charc_val_desc TYPE string VALUE 'i_clfncharcvaldescforkeydatetp',
    END OF gcs_vdm_entity_tp .
endinterface.