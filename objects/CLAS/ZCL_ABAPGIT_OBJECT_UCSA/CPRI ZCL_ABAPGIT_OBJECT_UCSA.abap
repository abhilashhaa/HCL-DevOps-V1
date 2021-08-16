  PRIVATE SECTION.
    CONSTANTS:
    BEGIN OF c_version,
      active   TYPE r3state VALUE 'A',
      inactive TYPE r3state VALUE 'I',
    END OF c_version .

    TYPES:
      ty_id TYPE c LENGTH 30.

    METHODS:
      get_persistence
        IMPORTING
          iv_id                 TYPE ty_id
        RETURNING
          VALUE(ro_persistence) TYPE REF TO object,

      clear_dynamic_fields
        CHANGING
          cg_complete_comm_assembly TYPE any,

      clear_field
        IMPORTING
          iv_fieldname TYPE csequence
        CHANGING
          cg_header    TYPE any.
