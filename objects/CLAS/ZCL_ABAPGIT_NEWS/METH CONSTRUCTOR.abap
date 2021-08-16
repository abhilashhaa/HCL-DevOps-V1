  METHOD constructor.

    DATA: lt_lines    TYPE string_table,
          lv_string   TYPE string,
          ls_log_line LIKE LINE OF mt_log.

    " Validate params
    mv_current_version  = normalize_version( iv_current_version ).
    mv_lastseen_version = normalize_version( iv_lastseen_version ).
    IF mv_current_version IS INITIAL.
      RETURN. " Internal format of program version is not correct -> abort parsing
    ENDIF.

    lv_string = zcl_abapgit_convert=>xstring_to_string_utf8( iv_rawdata ).
    lt_lines  = zcl_abapgit_convert=>split_string( lv_string ).
    mt_log    = parse( it_lines = lt_lines
                       iv_current_version = mv_current_version ).

    READ TABLE mt_log INTO ls_log_line INDEX 1.
    mv_latest_version = ls_log_line-version. " Empty if not found

  ENDMETHOD.