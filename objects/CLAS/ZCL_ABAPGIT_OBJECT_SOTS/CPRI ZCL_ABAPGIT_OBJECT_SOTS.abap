  PRIVATE SECTION.
    TYPES:
      BEGIN OF ty_sots,
        header  TYPE sotr_headu,
        entries TYPE sotr_textl_tt,
      END OF ty_sots,
      tty_sots TYPE STANDARD TABLE OF ty_sots
                    WITH NON-UNIQUE DEFAULT KEY.

    METHODS:
      read_sots
        RETURNING
          VALUE(rt_sots) TYPE tty_sots,

      create_sots
        IMPORTING
          is_sots    TYPE ty_sots
          iv_package TYPE devclass
          iv_object  TYPE trobjtype
        RAISING
          zcx_abapgit_exception,

      get_raw_text_filename
        IMPORTING
          is_entry           TYPE sotr_textl
        RETURNING
          VALUE(rv_filename) TYPE string.
