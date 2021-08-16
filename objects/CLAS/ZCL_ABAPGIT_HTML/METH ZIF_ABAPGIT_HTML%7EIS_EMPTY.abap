  METHOD zif_abapgit_html~is_empty.
    rv_yes = boolc( lines( mt_buffer ) = 0 ).
  ENDMETHOD.