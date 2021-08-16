  METHOD if_ngc_core_util~ctcv_syntax_check.
    CLEAR: string_is_masked, tstrg, sy_subrc.
    CALL FUNCTION 'CTCV_SYNTAX_CHECK'
      EXPORTING
        attribut                  = attribut
        baseunit                  = baseunit
        decimals                  = decimals
        dec_presentation          = dec_presentation
        exponent                  = exponent
        exponent_art              = exponent_art
        format                    = format
        interval                  = interval
        language                  = language
        length                    = length
        lowercase                 = lowercase
        mask                      = mask
        mask_allowed              = mask_allowed
        negativ                   = negativ
        screen_name               = screen_name
        single_selection          = single_selection
        string                    = string
        value_seperator           = value_seperator
        classtype                 = classtype
        t_separator               = t_separator
        err_name                  = err_name
      IMPORTING
        string_is_masked          = string_is_masked
      TABLES
        tstrg                     = tstrg
      EXCEPTIONS
        currency_check            = 1
        date_check                = 2
        format_check              = 3
        illegal_internal_baseunit = 4
        interval_check            = 5
        pattern_check             = 6
        time_check                = 7
        unit_check                = 8
        no_valid_dimension        = 9
        interval_not_allowed      = 10
        presentation_not_possible = 11
        OTHERS                    = 12.
    sy_subrc = sy-subrc.
    IF sy-subrc <> 0.
      CLEAR: string_is_masked, tstrg.
    ENDIF.
  ENDMETHOD.