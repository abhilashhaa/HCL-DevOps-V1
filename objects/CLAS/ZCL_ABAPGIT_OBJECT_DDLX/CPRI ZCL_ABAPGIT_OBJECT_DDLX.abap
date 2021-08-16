  PRIVATE SECTION.
    DATA mi_persistence TYPE REF TO if_wb_object_persist .
    METHODS get_persistence
      RETURNING
        VALUE(ri_persistence) TYPE REF TO if_wb_object_persist
      RAISING
        zcx_abapgit_exception .
    METHODS clear_fields
      CHANGING
        !cg_data TYPE any .
    METHODS clear_field
      IMPORTING
        !iv_fieldname TYPE csequence
      CHANGING
        !cg_metadata  TYPE any .