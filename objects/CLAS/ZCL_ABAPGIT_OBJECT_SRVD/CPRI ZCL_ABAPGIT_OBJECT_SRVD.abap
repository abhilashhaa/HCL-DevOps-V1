  PRIVATE SECTION.
    METHODS:
      clear_fields
        CHANGING
          cs_service_definition TYPE any,

      clear_field
        IMPORTING
          iv_fieldname          TYPE csequence
        CHANGING
          cs_service_definition TYPE any.

    DATA:
      mi_persistence            TYPE REF TO if_wb_object_persist,
      mv_service_definition_key TYPE seu_objkey,
      mr_service_definition     TYPE REF TO data.
