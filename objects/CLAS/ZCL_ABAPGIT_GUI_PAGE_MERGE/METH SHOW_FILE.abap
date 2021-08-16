  METHOD show_file.

    FIELD-SYMBOLS: <ls_show> LIKE LINE OF it_expanded.


    READ TABLE it_expanded ASSIGNING <ls_show>
        WITH KEY
        path = is_file-path
        name = is_file-name.
    IF sy-subrc = 0.
      IF <ls_show>-sha1 = is_result-sha1.
        ii_html->add( |<td>{ <ls_show>-path }{ <ls_show>-name }</td><td><b>{ <ls_show>-sha1(7) }</b></td>| ).
      ELSE.
        ii_html->add( |<td>{ <ls_show>-path }{ <ls_show>-name }</td><td>{ <ls_show>-sha1(7) }</td>| ).
      ENDIF.
    ELSE.
      ii_html->add( '<td></td><td></td>' ).
    ENDIF.

  ENDMETHOD.