  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_longtext,
        dokil TYPE dokil,
        head  TYPE thead,
        lines TYPE tline_tab,
      END OF ty_longtext .
    TYPES:
      tty_longtexts TYPE STANDARD TABLE OF ty_longtext
                           WITH NON-UNIQUE DEFAULT KEY .

    METHODS read
      IMPORTING
        !iv_object_name      TYPE sobj_name
        !iv_longtext_id      TYPE dokil-id
        !it_dokil            TYPE zif_abapgit_definitions=>tty_dokil
        !iv_master_lang_only TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(rt_longtexts)  TYPE tty_longtexts
      RAISING
        zcx_abapgit_exception .