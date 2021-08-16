INTERFACE if_ngc_c
  PUBLIC .

  CONSTANTS:
    BEGIN OF gc_object_state,
      loaded  TYPE ngc_core_object_state VALUE if_ngc_core_c=>gc_object_state-loaded,
      created TYPE ngc_core_object_state VALUE if_ngc_core_c=>gc_object_state-created,
      updated TYPE ngc_core_object_state VALUE if_ngc_core_c=>gc_object_state-updated,
      deleted TYPE ngc_core_object_state VALUE if_ngc_core_c=>gc_object_state-deleted,
*      archived      TYPE c LENGTH 10 VALUE 'ARCHIVED' ##NO_TEXT,
*      deleted       TYPE c LENGTH 10 VALUE 'DELETED' ##NO_TEXT,
*      freed         TYPE c LENGTH 10 VALUE 'FREED' ##NO_TEXT,
*      to_be_created TYPE c LENGTH 10 VALUE '2BECREATED' ##NO_TEXT,
*      deleted       TYPE c LENGTH 10 VALUE '2BEDELETED' ##NO_TEXT,
    END OF gc_object_state .

  CONSTANTS:
    BEGIN OF gc_message_severity,
      info    TYPE symsgty VALUE 'I',
      warning TYPE symsgty VALUE 'W',
      error   TYPE symsgty VALUE 'E',
    END OF gc_message_severity .

  CONSTANTS:
    BEGIN OF gc_charcdatatype,
      char TYPE atfor VALUE if_ngc_core_c=>gc_charcdatatype-char,
      num  TYPE atfor VALUE if_ngc_core_c=>gc_charcdatatype-num,
      curr TYPE atfor VALUE if_ngc_core_c=>gc_charcdatatype-curr,
      date TYPE atfor VALUE if_ngc_core_c=>gc_charcdatatype-date,
      time TYPE atfor VALUE if_ngc_core_c=>gc_charcdatatype-time,
    END OF gc_charcdatatype .

  CONSTANTS:
    BEGIN OF gc_msg_severity_category,
      error_or_worse TYPE c LENGTH 3 VALUE if_ngc_core_c=>gc_msg_severity_category-error_or_worse,
    END OF gc_msg_severity_category .

  CONSTANTS: gc_obj_clf_ecn_obj_type TYPE aetyp VALUE if_ngc_core_c=>gc_obj_clf_ecn_obj_type.

  CONSTANTS:
    BEGIN OF gc_clf_object_class_indicator,
      object TYPE klmaf VALUE if_ngc_core_c=>gc_clf_object_class_indicator-object,
      class  TYPE klmaf VALUE if_ngc_core_c=>gc_clf_object_class_indicator-class,
    END OF gc_clf_object_class_indicator .

  CONSTANTS: gc_positionnumber_increment TYPE posnummer VALUE 10.
  CONSTANTS: gc_positionnumber_default TYPE posnummer VALUE 10.
  CONSTANTS: gc_charclength_default TYPE anzst VALUE 30.
  CONSTANTS: gc_date_zero TYPE dats VALUE if_ngc_core_c=>gc_date_zero.
  CONSTANTS: gc_date_min TYPE dats VALUE if_ngc_core_c=>gc_date_min.
  CONSTANTS: gc_date_max TYPE dats VALUE if_ngc_core_c=>gc_date_max.
  CONSTANTS: gc_time_max TYPE tims VALUE if_ngc_core_c=>gc_time_max.
  CONSTANTS: gc_time_min TYPE tims VALUE if_ngc_core_c=>gc_time_min.

ENDINTERFACE.