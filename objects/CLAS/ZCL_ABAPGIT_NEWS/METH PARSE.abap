  METHOD parse.

    DATA: lv_tail                TYPE i,
          lv_first_version_found TYPE abap_bool,
          lv_version             TYPE string,
          ls_log                 LIKE LINE OF rt_log.

    FIELD-SYMBOLS: <lv_line> LIKE LINE OF it_lines.


    LOOP AT it_lines ASSIGNING <lv_line>.
      ls_log = parse_line( iv_line = <lv_line>
                           iv_current_version = iv_current_version ).

      " Skip until first version head and Skip empty lines
      CHECK ls_log IS NOT INITIAL AND
            ( lv_first_version_found = abap_true OR ls_log-version IS NOT INITIAL ).

      IF lv_first_version_found = abap_false.
        lv_first_version_found = abap_true.
        IF compare_versions( iv_a = ls_log-version
                             iv_b = iv_current_version ) <= 0.
          lv_tail = c_tail_length. " Display some last versions if no updates
        ENDIF.
      ENDIF.

      IF ls_log-is_header = abap_true.
        "Skip everything below current version or show tail news
        IF compare_versions( iv_a = ls_log-version
                             iv_b = iv_current_version ) <= 0.
          IF lv_tail > 0.
            lv_tail = lv_tail - 1.
          ELSE.
            EXIT.
          ENDIF.
        ENDIF.
        lv_version = ls_log-version. " Save to fill news lines
      ELSE.
        ls_log-version = lv_version.
      ENDIF.

      APPEND ls_log TO rt_log.
    ENDLOOP.

  ENDMETHOD.