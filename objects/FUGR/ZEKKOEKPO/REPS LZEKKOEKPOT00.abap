*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 26.03.2021 at 06:07:57
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZEKKOEKPO.......................................*
DATA:  BEGIN OF STATUS_ZEKKOEKPO                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZEKKOEKPO                     .
CONTROLS: TCTRL_ZEKKOEKPO
            TYPE TABLEVIEW USING SCREEN '9001'.
*.........table declarations:.................................*
TABLES: *ZEKKOEKPO                     .
TABLES: ZEKKOEKPO                      .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .