INTERFACE if_ngc_bil_cls_c
  PUBLIC .

  TYPES:
    BEGIN OF lty_clfnclasstp,
      t_create      TYPE TABLE FOR CREATE   i_clfnclassforkeydatetp,
      t_delete      TYPE TABLE FOR DELETE   i_clfnclassforkeydatetp,
      t_update      TYPE TABLE FOR UPDATE   i_clfnclassforkeydatetp,

      t_mapped      TYPE TABLE FOR MAPPED   i_clfnclassforkeydatetp,
      t_failed      TYPE TABLE FOR FAILED   i_clfnclassforkeydatetp,
      t_reported    TYPE TABLE FOR REPORTED i_clfnclassforkeydatetp,

      t_mapped_late TYPE TABLE FOR MAPPED LATE i_clfnclassforkeydatetp,

      t_read_in     TYPE TABLE FOR READ IMPORT i_clfnclassforkeydatetp,
      t_read_out    TYPE TABLE FOR READ RESULT i_clfnclassforkeydatetp,

      s_update      TYPE LINE OF lty_clfnclasstp-t_update,
      s_create      TYPE LINE OF lty_clfnclasstp-t_create,
    END OF lty_clfnclasstp .
  TYPES:
    BEGIN OF lty_clfnclassdesctp,
      t_create        TYPE TABLE FOR CREATE   i_clfnclassforkeydatetp\_classdescription,
      t_update        TYPE TABLE FOR UPDATE   i_clfnclassdescforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfnclassdescforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfnclassdescforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfnclassdescforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfnclassdescforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfnclassdescforkeydatetp,

      t_read_in     TYPE TABLE FOR READ IMPORT i_clfnclassdescforkeydatetp,
      t_read_out    TYPE TABLE FOR READ RESULT i_clfnclassdescforkeydatetp,

      s_update      TYPE LINE OF lty_clfnclassdesctp-t_update,
    END OF lty_clfnclassdesctp .
  TYPES:
    BEGIN OF lty_clfnclasskeywordtp,
      t_create        TYPE TABLE FOR CREATE   i_clfnclassforkeydatetp\_classkeyword,
      t_delete        TYPE TABLE FOR DELETE   i_clfnclasskeywordforkeydatetp,
      t_update        TYPE TABLE FOR UPDATE   i_clfnclasskeywordforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfnclasskeywordforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfnclasskeywordforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfnclasskeywordforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfnclasskeywordforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfnclasskeywordforkeydatetp,

      t_read_in     TYPE TABLE FOR READ IMPORT i_clfnclasskeywordforkeydatetp,
      t_read_out    TYPE TABLE FOR READ RESULT i_clfnclasskeywordforkeydatetp,

      s_update      TYPE LINE OF lty_clfnclasskeywordtp-t_update,
    END OF lty_clfnclasskeywordtp .
  TYPES:
    BEGIN OF lty_clfnclasstexttp,
      t_create        TYPE TABLE FOR CREATE   i_clfnclassforkeydatetp\_classtext,
      t_delete        TYPE TABLE FOR DELETE   i_clfnclasstextforkeydatetp,
      t_update        TYPE TABLE FOR UPDATE   i_clfnclasstextforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfnclasstextforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfnclasstextforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfnclasstextforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfnclasstextforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfnclasstextforkeydatetp,

      t_read_in     TYPE TABLE FOR READ IMPORT i_clfnclasstextforkeydatetp,
      t_read_out    TYPE TABLE FOR READ RESULT i_clfnclasstextforkeydatetp,

      s_update      TYPE LINE OF lty_clfnclasstexttp-t_update,
    END OF lty_clfnclasstexttp .
  TYPES:
    BEGIN OF lty_clfnclasscharctp,
      t_create        TYPE TABLE FOR CREATE   i_clfnclassforkeydatetp\_classcharacteristic,
      t_delete        TYPE TABLE FOR DELETE   i_clfnclasscharcforkeydatetp,
      t_update        TYPE TABLE FOR UPDATE   i_clfnclasscharcforkeydatetp,
      t_create_direct TYPE TABLE FOR CREATE   i_clfnclasscharcforkeydatetp,

      t_mapped        TYPE TABLE FOR MAPPED   i_clfnclasscharcforkeydatetp,
      t_failed        TYPE TABLE FOR FAILED   i_clfnclasscharcforkeydatetp,
      t_reported      TYPE TABLE FOR REPORTED i_clfnclasscharcforkeydatetp,

      t_mapped_late   TYPE TABLE FOR MAPPED LATE i_clfnclasscharcforkeydatetp,

      t_read_in     TYPE TABLE FOR READ IMPORT i_clfnclasscharcforkeydatetp,
      t_read_out    TYPE TABLE FOR READ RESULT i_clfnclasscharcforkeydatetp,

      s_update        TYPE LINE OF lty_clfnclasscharctp-t_update,

    END OF lty_clfnclasscharctp .

  CONSTANTS:
    BEGIN OF gcs_vdm_entity_tp,
      class         TYPE string VALUE 'i_clfnclassforkeydatetp',
      class_desc    TYPE string VALUE 'i_clfnclassdescforkeydatetp',
      class_keyword TYPE string VALUE 'i_clfnclasskeywordforkeydatetp',
      class_charc   TYPE string VALUE 'i_clfnclasscharcforkeydatetp',
      class_text    TYPE string VALUE 'i_clfnclasstextforkeydatetp',
    END OF gcs_vdm_entity_tp .

ENDINTERFACE.