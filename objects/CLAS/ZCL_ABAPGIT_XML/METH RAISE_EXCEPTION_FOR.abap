  METHOD raise_exception_for.
    DATA lv_message TYPE string.

    lv_message = |XML parser error: { ii_error->get_reason( ) }, | &&
                 |Line { ii_error->get_line( ) } | &&
                 |Col. { ii_error->get_column( ) }|.

    IF mv_filename IS NOT INITIAL.
      lv_message = lv_message && | File { mv_filename }|.
    ENDIF.

    zcx_abapgit_exception=>raise( lv_message ).

  ENDMETHOD.