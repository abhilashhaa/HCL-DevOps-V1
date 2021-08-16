class TH_NGC_BIL_CHR_DATA definition
  public
  final
  create public
  for testing .

public section.

  types:
    BEGIN OF LTY_s_CHARC_CONTROL.
    TYPES: characteristic_ref TYPE atnam.
    INCLUDE TYPE IF_NGC_BIL_CHR_C=>LTY_CLFNCHARCTP-S_CREATE-%CONTROL .
  TYPES: END OF lty_s_charc_control .
  types:
    lty_t_charc_control TYPE STANDARD TABLE OF lty_s_charc_control WITH DEFAULT KEY .

  constants CV_KEYDATE_2017 type DATS value '20170101' ##NO_TEXT.
  constants CV_KEYDATE_2018 type DATS value '20180101' ##NO_TEXT.
  constants CV_KEYDATE_2019 type DATS value '20190101' ##NO_TEXT.
  constants CV_CHARC_CURR_ID type ATINN value 0000000005 ##NO_TEXT.
  constants CV_CHARC_DATE_ID type ATINN value 0000000004 ##NO_TEXT.
  constants CV_CHARC_TIME_ID type ATINN value 0000000003 ##NO_TEXT.
  constants CV_CHARC_NUM_ID type ATINN value 0000000002 ##NO_TEXT.
  constants CV_CHARC_CHAR_ID type ATINN value 0000000001 ##NO_TEXT.
  constants CV_CHARC_CHAR_ID_TMP type ATINN value 1000000000 ##NO_TEXT.
  constants CV_CHARC_CHAR_NAME type ATNAM value 'CHAR_CHAR' ##NO_TEXT.
  constants CV_CHARC_NUM_NAME type ATNAM value 'CHAR_NUM' ##NO_TEXT.
  constants CV_CHARC_TIME_NAME type ATNAM value 'CHAR_TIME' ##NO_TEXT.
  constants CV_CHARC_DATE_NAME type ATNAM value 'CHAR_DATE' ##NO_TEXT.
  constants CV_CHARC_CURR_NAME type ATNAM value 'CHAR_CURR' ##NO_TEXT.
  constants CV_CHANGENUMBER_2017 type AENNR value 'CH_2017' ##NO_TEXT.
  constants CV_CHANGENUMBER_2018 type AENNR value 'CH_2018' ##NO_TEXT.
  constants CV_CHANGENUMBER_2019 type AENNR value 'CH_2019' ##NO_TEXT.
  constants CV_CHANGENUMBER_NOT_EXISTING type AENNR value 'CH_NOT_EXIST' ##NO_TEXT.