  METHOD version_greater_or_equal.

    DATA: lv_number TYPE n LENGTH 4 ##NEEDED.

    TRY.
        MOVE EXACT: is_status-installed_release TO lv_number,
                    is_status-installed_patch   TO lv_number,
                    is_status-required_release  TO lv_number,
                    is_status-required_patch    TO lv_number.
      CATCH cx_sy_conversion_error.
        " Cannot compare by number, assume requirement not fullfilled (user can force install
        " anyways if this was an error)
        rv_true = abap_false.
        RETURN.
    ENDTRY.

    " Versions are comparable by number, compare release and if necessary patch level
    IF is_status-installed_release > is_status-required_release
        OR ( is_status-installed_release = is_status-required_release
        AND ( is_status-required_patch IS INITIAL OR
        is_status-installed_patch >= is_status-required_patch ) ).

      rv_true = abap_true.
    ENDIF.

  ENDMETHOD.