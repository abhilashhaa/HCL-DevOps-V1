  METHOD set_patch_by_old_diff.

    FIELD-SYMBOLS: <ls_diff> TYPE zif_abapgit_definitions=>ty_diff.

    LOOP AT mt_diff ASSIGNING <ls_diff>
                    WHERE old     = is_diff_old-old
                    AND   new     = is_diff_old-new
                    AND   new_num = is_diff_old-new_num
                    AND   old_num = is_diff_old-old_num.

      <ls_diff>-patch_flag = iv_patch_flag.
      EXIT.

    ENDLOOP.

  ENDMETHOD.