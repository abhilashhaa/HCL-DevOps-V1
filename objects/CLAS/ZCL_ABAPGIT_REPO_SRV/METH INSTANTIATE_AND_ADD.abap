  METHOD instantiate_and_add.

    IF is_repo_meta-offline = abap_false.
      CREATE OBJECT ro_repo TYPE zcl_abapgit_repo_online
        EXPORTING
          is_data = is_repo_meta.
    ELSE.
      CREATE OBJECT ro_repo TYPE zcl_abapgit_repo_offline
        EXPORTING
          is_data = is_repo_meta.
    ENDIF.
    add( ro_repo ).

  ENDMETHOD.