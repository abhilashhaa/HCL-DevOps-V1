  METHOD get_top_of_callstack.

    READ TABLE mt_callstack INDEX 1
                            INTO rs_top_of_callstack.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Callstack is empty| ).
    ENDIF.

  ENDMETHOD.