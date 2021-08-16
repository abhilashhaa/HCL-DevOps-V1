  METHOD dispatch.

    CASE iv_column.
      WHEN `LONGTEXT`.

        show_longtext( is_log ).

      WHEN `T100`.

        goto_t100_message( is_log ).

      WHEN `SOURCE`.

        goto_source( is_log ).

      WHEN `CALLSTACK`.

        goto_callstack( is_log ).

    ENDCASE.

  ENDMETHOD.