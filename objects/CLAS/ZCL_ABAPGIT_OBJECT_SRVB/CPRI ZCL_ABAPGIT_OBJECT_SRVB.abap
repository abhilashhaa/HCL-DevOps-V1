  PRIVATE SECTION.
    METHODS:
      clear_fields
        CHANGING
          cs_service_binding TYPE any,

      clear_field
        IMPORTING
          iv_fieldname       TYPE csequence
        CHANGING
          cs_service_binding TYPE any.

    DATA:
      mi_persistence         TYPE REF TO if_wb_object_persist,
      mv_service_binding_key TYPE seu_objkey,
      mr_service_binding     TYPE REF TO data.
