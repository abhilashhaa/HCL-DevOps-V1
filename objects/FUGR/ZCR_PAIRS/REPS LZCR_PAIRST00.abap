*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 25.07.2020 at 10:01:32
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZCR_PAIRS.......................................*
DATA:  BEGIN OF STATUS_ZCR_PAIRS                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCR_PAIRS                     .
CONTROLS: TCTRL_ZCR_PAIRS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZCR_PAIRS                     .
TABLES: ZCR_PAIRS                      .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .