  PRIVATE SECTION.
    DATA:
      mv_toggle_id TYPE c LENGTH 40, "sftgl_ft_id
      mr_toggle    TYPE REF TO data.

    METHODS:
      clear_field
        IMPORTING
          iv_fieldname TYPE string
        CHANGING
          cg_header    TYPE any.
