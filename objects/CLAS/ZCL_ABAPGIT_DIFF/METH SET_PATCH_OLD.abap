  METHOD set_patch_old.

    DATA: lv_old_num TYPE i.
    FIELD-SYMBOLS: <ls_diff> TYPE zif_abapgit_definitions=>ty_diff.

    LOOP AT mt_diff ASSIGNING <ls_diff>.

      lv_old_num = <ls_diff>-old_num.

      IF lv_old_num = iv_line_old.
        EXIT.
      ENDIF.

    ENDLOOP.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Invalid old line number { iv_line_old }| ).
    ENDIF.

    <ls_diff>-patch_flag = iv_patch_flag.

  ENDMETHOD.