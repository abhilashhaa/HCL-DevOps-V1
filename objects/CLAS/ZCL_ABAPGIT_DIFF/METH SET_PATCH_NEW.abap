  METHOD set_patch_new.

    DATA: lv_new_num TYPE i.
    FIELD-SYMBOLS: <ls_diff> TYPE zif_abapgit_definitions=>ty_diff.

    LOOP AT mt_diff ASSIGNING <ls_diff>.

      lv_new_num = <ls_diff>-new_num.

      IF lv_new_num = iv_line_new.
        EXIT.
      ENDIF.

    ENDLOOP.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Invalid new line number { iv_line_new }| ).
    ENDIF.

    <ls_diff>-patch_flag = iv_patch_flag.

  ENDMETHOD.