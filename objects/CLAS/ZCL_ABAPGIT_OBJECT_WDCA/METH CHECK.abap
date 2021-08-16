  METHOD check.

    FIELD-SYMBOLS: <ls_message> TYPE LINE OF cts_messages.

    LOOP AT it_messages ASSIGNING <ls_message> WHERE severity = 'E'.
      zcx_abapgit_exception=>raise( <ls_message>-text ).
    ENDLOOP.

  ENDMETHOD.