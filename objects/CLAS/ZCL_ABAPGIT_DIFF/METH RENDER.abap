  METHOD render.

    DATA: lv_oindex TYPE i VALUE 1,
          lv_nindex TYPE i VALUE 1,
          ls_new    LIKE LINE OF it_new,
          ls_old    LIKE LINE OF it_old,
          ls_diff   LIKE LINE OF rt_diff,
          lt_delta  LIKE it_delta,
          ls_delta  LIKE LINE OF it_delta.


    lt_delta = it_delta.

    DO.
      READ TABLE lt_delta INTO ls_delta WITH KEY number = lv_oindex.
      IF sy-subrc = 0.
        DELETE lt_delta INDEX sy-tabix.

        CASE ls_delta-vrsflag.
          WHEN zif_abapgit_definitions=>c_diff-delete.
            ls_diff-new = ''.
            ls_diff-result = zif_abapgit_definitions=>c_diff-delete.
            ls_diff-old = ls_delta-line.

            lv_oindex = lv_oindex + 1.
          WHEN zif_abapgit_definitions=>c_diff-insert.
            ls_diff-new = ls_delta-line.
            ls_diff-result = zif_abapgit_definitions=>c_diff-insert.
            ls_diff-old = ''.

            lv_nindex = lv_nindex + 1.
          WHEN zif_abapgit_definitions=>c_diff-update.
            CLEAR ls_new.
            READ TABLE it_new INTO ls_new INDEX lv_nindex.
            ASSERT sy-subrc = 0.

            ls_diff-new = ls_new.
            ls_diff-result = zif_abapgit_definitions=>c_diff-update.
            ls_diff-old = ls_delta-line.

            lv_nindex = lv_nindex + 1.
            lv_oindex = lv_oindex + 1.
          WHEN OTHERS.
            ASSERT 0 = 1.
        ENDCASE.
      ELSE.
        CLEAR ls_new.
        READ TABLE it_new INTO ls_new INDEX lv_nindex.    "#EC CI_SUBRC
        lv_nindex = lv_nindex + 1.
        CLEAR ls_old.
        READ TABLE it_old INTO ls_old INDEX lv_oindex.    "#EC CI_SUBRC
        lv_oindex = lv_oindex + 1.

        ls_diff-new = ls_new.
        ls_diff-result = ''.
        ls_diff-old = ls_old.
      ENDIF.

      APPEND ls_diff TO rt_diff.
      CLEAR ls_diff.

      IF lv_nindex > lines( it_new ) AND lv_oindex > lines( it_old ).
        EXIT.
      ENDIF.
    ENDDO.

  ENDMETHOD.