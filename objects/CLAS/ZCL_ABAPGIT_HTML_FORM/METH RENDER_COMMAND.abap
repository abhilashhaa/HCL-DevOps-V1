  METHOD render_command.

    DATA lv_main_submit TYPE string.

    IF is_cmd-as_a = abap_true.
      ii_html->add_a(
        iv_txt = is_cmd-label
        iv_act = is_cmd-action
        iv_class = 'dialog-commands' ).
    ELSE.
      IF is_cmd-is_main = abap_true.
        lv_main_submit = ' class="main"'.
      ELSE.
        CLEAR lv_main_submit.
      ENDIF.
      ii_html->add( |<input type="submit" value="{
        is_cmd-label }"{ lv_main_submit } formaction="sapevent:{ is_cmd-action }">| ).
    ENDIF.

  ENDMETHOD.