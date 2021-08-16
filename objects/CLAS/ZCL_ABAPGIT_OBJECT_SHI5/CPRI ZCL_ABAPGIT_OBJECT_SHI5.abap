  PRIVATE SECTION.
    TYPES: tty_ttree_extt TYPE STANDARD TABLE OF ttree_extt
                               WITH NON-UNIQUE DEFAULT KEY,
           BEGIN OF ty_extension,
             header    TYPE ttree_ext,
             texts     TYPE tty_ttree_extt,
             sequences TYPE STANDARD TABLE OF ttrees WITH NON-UNIQUE DEFAULT KEY,
           END OF ty_extension.

    DATA: mv_extension TYPE hier_names.
