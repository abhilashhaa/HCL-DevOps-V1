  METHOD create_charc.
    DATA: ls_detail TYPE bapicharactdetail,
          lt_desc   TYPE STANDARD TABLE OF bapicharactdescr,
          ls_desc   TYPE bapicharactdescr,
          lt_char   TYPE STANDARD TABLE OF bapicharactvalueschar,
          ls_char   TYPE bapicharactvalueschar,
          lt_return TYPE STANDARD TABLE OF bapiret2.

    ls_detail-charact_name = is_charc-characteristic.
    ls_detail-data_type    = is_charc-charcdatatype.
    ls_detail-length       = is_charc-charclength.
    ls_detail-status       = 1.
    ls_desc-description    = 'unit test ' && is_charc-characteristic.
    ls_desc-language_int   = 'E'.
    APPEND ls_desc TO lt_desc.
    ls_char-value_char = 'AA'.
    APPEND ls_char TO lt_char.
    ls_char-value_char = 'BB'.
    APPEND ls_char TO lt_char.
    ls_char-value_char = 'CC'.
    APPEND ls_char TO lt_char.
    CALL FUNCTION 'BAPI_CHARACT_CREATE'
      EXPORTING
        charactdetail     = ls_detail
      TABLES
        charactdescr      = lt_desc
        charactvalueschar = lt_char
        return            = lt_return.
  ENDMETHOD.