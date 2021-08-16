  METHOD convert_separator_to_user_mask.

    rv_template = iv_template.

    mo_core_util->get_number_separator_signs(
        IMPORTING
          ev_decimal_sign = DATA(lv_decimal_sign)
          ev_separator    = DATA(lv_separator) ).

    CASE lv_separator.
      WHEN ','.

*      CASE iv_dec_sep.
*        WHEN '.'.
* not possible (user representation = DB representation)
*        WHEN ','.
* not possible
*      ENDCASE.

      WHEN '.'.
        CASE lv_decimal_sign.
          WHEN ','.
            TRANSLATE rv_template USING ',..,'.
*       WHEN '.'.
* not possible
        ENDCASE.

      WHEN ' '.
        CASE lv_decimal_sign.
*       WHEN '.'.
* not possible
          WHEN ','.
            TRANSLATE rv_template USING ', .,'.
        ENDCASE.

    ENDCASE.

  ENDMETHOD.