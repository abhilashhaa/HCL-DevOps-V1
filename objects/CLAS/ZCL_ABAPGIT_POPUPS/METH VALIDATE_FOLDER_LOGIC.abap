  METHOD validate_folder_logic.

    IF iv_folder_logic <> zif_abapgit_dot_abapgit=>c_folder_logic-prefix
        AND iv_folder_logic <> zif_abapgit_dot_abapgit=>c_folder_logic-full.

      zcx_abapgit_exception=>raise( |Invalid folder logic { iv_folder_logic }. |
                                 && |Choose either { zif_abapgit_dot_abapgit=>c_folder_logic-prefix } |
                                 && |or { zif_abapgit_dot_abapgit=>c_folder_logic-full } | ).

    ENDIF.

  ENDMETHOD.