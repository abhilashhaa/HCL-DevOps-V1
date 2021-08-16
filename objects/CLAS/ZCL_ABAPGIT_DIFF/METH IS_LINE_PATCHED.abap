  METHOD is_line_patched.

    FIELD-SYMBOLS: <ls_diff> TYPE zif_abapgit_definitions=>ty_diff.

    READ TABLE mt_diff INDEX iv_index
                       ASSIGNING <ls_diff>.
    IF sy-subrc = 0.
      rv_patched = <ls_diff>-patch_flag.
    ELSE.
      zcx_abapgit_exception=>raise( |Diff line not found { iv_index }| ).
    ENDIF.

  ENDMETHOD.