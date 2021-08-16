*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 25.07.2020 at 09:06:30
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZCR_GAMES.......................................*
DATA:  BEGIN OF STATUS_ZCR_GAMES                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCR_GAMES                     .
CONTROLS: TCTRL_ZCR_GAMES
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZCR_GAMES                     .
TABLES: ZCR_GAMES                      .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .