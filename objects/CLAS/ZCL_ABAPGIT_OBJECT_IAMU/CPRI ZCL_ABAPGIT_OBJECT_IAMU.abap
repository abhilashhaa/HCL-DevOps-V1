  PRIVATE SECTION.
    TYPES: BEGIN OF ty_internet_appl_comp_binary,
             attributes TYPE w3mimeattr,
             source     TYPE w3mimetabtype,
             length     TYPE i,
           END OF ty_internet_appl_comp_binary.

    DATA: mi_mime_api TYPE REF TO if_w3_api_mime.

    METHODS:
      load_mime_api
        RAISING
          zcx_abapgit_exception,

      read
        RETURNING
          VALUE(rs_internet_appl_comp_binary) TYPE ty_internet_appl_comp_binary
        RAISING
          zcx_abapgit_exception,

      save
        IMPORTING
          is_internet_appl_comp_binary TYPE ty_internet_appl_comp_binary
        RAISING
          zcx_abapgit_exception,

      release_lock
        RAISING
          zcx_abapgit_exception.
