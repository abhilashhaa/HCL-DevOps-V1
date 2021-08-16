  PRIVATE SECTION.

    CLASS-METHODS field_keys_to_upper
      CHANGING
        !ct_fields TYPE tihttpnvp .
    CLASS-METHODS add_field
      IMPORTING
        !iv_name  TYPE string
        !ig_field TYPE any
      CHANGING
        !ct_field TYPE tihttpnvp .
    CLASS-METHODS unescape
      IMPORTING
        !iv_string       TYPE string
      RETURNING
        VALUE(rv_string) TYPE string .