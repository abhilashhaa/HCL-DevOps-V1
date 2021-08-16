  PRIVATE SECTION.
    CONSTANTS: c_typ     TYPE dokhl-typ VALUE 'E',
               c_version TYPE dokhl-dokversion VALUE '0001',
               c_name    TYPE string VALUE 'DOC'.

    TYPES: BEGIN OF ty_data,
             doctitle TYPE dsyst-doktitle,
             head     TYPE thead,
             lines    TYPE tline_tab,
           END OF ty_data.

    METHODS: read
      RETURNING VALUE(rs_data) TYPE ty_data.
