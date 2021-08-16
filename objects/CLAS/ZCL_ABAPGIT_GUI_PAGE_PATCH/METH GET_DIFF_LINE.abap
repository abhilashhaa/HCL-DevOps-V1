  METHOD get_diff_line.

    DATA: lt_diff       TYPE zif_abapgit_definitions=>ty_diffs_tt,
          lv_line_index TYPE sy-tabix.


    lv_line_index = iv_line_index.
    lt_diff = io_diff->get( ).

    READ TABLE lt_diff INTO rs_diff
                       INDEX lv_line_index.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Invalid line index { lv_line_index }| ).
    ENDIF.

  ENDMETHOD.