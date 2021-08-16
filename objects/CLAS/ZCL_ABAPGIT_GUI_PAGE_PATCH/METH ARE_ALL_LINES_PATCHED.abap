  METHOD are_all_lines_patched.

    DATA: lv_patch_count TYPE i.

    FIELD-SYMBOLS: <ls_diff> TYPE zif_abapgit_definitions=>ty_diff.

    LOOP AT it_diff ASSIGNING <ls_diff>
                    WHERE patch_flag = abap_true.
      lv_patch_count = lv_patch_count + 1.
    ENDLOOP.

    rv_are_all_lines_patched = boolc( lv_patch_count = lines( it_diff ) ).

  ENDMETHOD.