  METHOD find_head_offset.

    rv_head_end = find( val = iv_html
                        regex = |{ cl_abap_char_utilities=>newline }?\\s*</head>|
                        case = abap_false ).
    IF rv_head_end <= 0.
      rv_head_end = find( val = iv_html
                          regex = |</head>|
                          case = abap_false ).
      IF rv_head_end <= 0.
        zcx_abapgit_exception=>raise( 'HTML preprocessor: </head> not found' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.