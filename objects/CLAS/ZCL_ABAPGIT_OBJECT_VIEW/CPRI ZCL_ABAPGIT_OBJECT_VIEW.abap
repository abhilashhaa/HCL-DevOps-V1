  PRIVATE SECTION.
    TYPES: tty_dd26v TYPE STANDARD TABLE OF dd26v
                          WITH NON-UNIQUE DEFAULT KEY,
           tty_dd27p TYPE STANDARD TABLE OF dd27p
                          WITH NON-UNIQUE DEFAULT KEY,
           tty_dd28j TYPE STANDARD TABLE OF dd28j
                          WITH NON-UNIQUE DEFAULT KEY,
           tty_dd28v TYPE STANDARD TABLE OF dd28v
                          WITH NON-UNIQUE DEFAULT KEY.
    CONSTANTS: BEGIN OF co_viewclass,
                 help         TYPE viewclass VALUE 'H',
                 database     TYPE viewclass VALUE 'D',
                 projection   TYPE viewclass VALUE 'P',
                 structure    TYPE viewclass VALUE 'S',
                 maintenance  TYPE viewclass VALUE 'C',
                 entity       TYPE viewclass VALUE 'E',
                 view_variant TYPE viewclass VALUE 'V',
                 append       TYPE viewclass VALUE 'A',
                 external     TYPE viewclass VALUE 'X',
                 replication  TYPE viewclass VALUE 'R',
               END OF co_viewclass.

    METHODS:
      read_view
        EXPORTING
          es_dd25v TYPE dd25v
          es_dd09l TYPE dd09l
          et_dd26v TYPE tty_dd26v
          et_dd27p TYPE tty_dd27p
          et_dd28j TYPE tty_dd28j
          et_dd28v TYPE tty_dd28v
        RAISING
          zcx_abapgit_exception.
