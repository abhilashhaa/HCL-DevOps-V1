  METHOD apply_patch_for.

    DATA: lo_diff      TYPE REF TO zcl_abapgit_diff,
          ls_diff_line TYPE zif_abapgit_definitions=>ty_diff,
          lv_line      TYPE i.

    lo_diff = get_diff_object( iv_filename ).

    ls_diff_line = get_diff_line( io_diff       = lo_diff
                                  iv_line_index = iv_line_index ).

    CASE ls_diff_line-result.
      WHEN zif_abapgit_definitions=>c_diff-update
        OR zif_abapgit_definitions=>c_diff-insert.

        lv_line = ls_diff_line-new_num.

        lo_diff->set_patch_new( iv_line_new   = lv_line
                                iv_patch_flag = iv_patch_flag ).

      WHEN zif_abapgit_definitions=>c_diff-delete.

        lv_line = ls_diff_line-old_num.

        lo_diff->set_patch_old( iv_line_old   = lv_line
                                iv_patch_flag = iv_patch_flag ).

    ENDCASE.

  ENDMETHOD.