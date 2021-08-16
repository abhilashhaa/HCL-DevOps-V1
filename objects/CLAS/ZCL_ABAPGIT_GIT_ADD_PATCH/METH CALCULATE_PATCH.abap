  METHOD calculate_patch.

    FIELD-SYMBOLS: <ls_diff> LIKE LINE OF mt_diff.

    LOOP AT mt_diff ASSIGNING <ls_diff>.

      CASE <ls_diff>-result.
        WHEN ' '.

          INSERT <ls_diff>-new INTO TABLE rt_patch.

        WHEN zif_abapgit_definitions=>c_diff-insert.

          IF <ls_diff>-patch_flag = abap_true.
            INSERT <ls_diff>-new INTO TABLE rt_patch.
          ENDIF.

        WHEN zif_abapgit_definitions=>c_diff-delete.

          IF <ls_diff>-patch_flag = abap_false.
            INSERT <ls_diff>-old INTO TABLE rt_patch.
          ENDIF.

        WHEN zif_abapgit_definitions=>c_diff-update.

          IF <ls_diff>-patch_flag = abap_true.
            INSERT <ls_diff>-new INTO TABLE rt_patch.
          ELSE.
            INSERT <ls_diff>-old INTO TABLE rt_patch.
          ENDIF.

        WHEN OTHERS.

          zcx_abapgit_exception=>raise( |Unknown result| ).

      ENDCASE.

    ENDLOOP.

  ENDMETHOD.