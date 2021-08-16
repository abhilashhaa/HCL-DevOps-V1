  METHOD to_html.

    DATA: lt_message TYPE zif_abapgit_log=>tty_log_out,
          lr_message TYPE REF TO zif_abapgit_log=>ty_log_out,
          lv_class   TYPE string,
          lv_icon    TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    IF ii_log->count( ) = 0.
      RETURN.
    ENDIF.

    lt_message = ii_log->get_messages( ).

    LOOP AT lt_message REFERENCE INTO lr_message.
      CASE lr_message->type.
        WHEN 'W'.
          lv_icon  = 'attention'.
          lv_class = 'warning'.
        WHEN 'E'.
          lv_icon  = 'error'.
          lv_class = 'error'.
        WHEN OTHERS. " ??? unexpected
          lv_icon  = 'error'.
          lv_class = 'error'.
      ENDCASE.

      ri_html->add( |<span class="{ lv_class }">| ).
      ri_html->add_icon( lv_icon ).
      ri_html->add( lr_message->text ).
      ri_html->add( '</span>' ).
    ENDLOOP.

  ENDMETHOD.