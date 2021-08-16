  METHOD build_default.

    DATA: ls_data TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit.


    ls_data-master_language = sy-langu.
    ls_data-starting_folder = '/src/'.
    ls_data-folder_logic    = zif_abapgit_dot_abapgit=>c_folder_logic-prefix.

    APPEND '/.gitignore' TO ls_data-ignore.
    APPEND '/LICENSE' TO ls_data-ignore.
    APPEND '/README.md' TO ls_data-ignore.
    APPEND '/package.json' TO ls_data-ignore.
    APPEND '/.travis.yml' TO ls_data-ignore.
    APPEND '/.gitlab-ci.yml' TO ls_data-ignore.
    APPEND '/abaplint.json' TO ls_data-ignore.
    APPEND '/azure-pipelines.yml' TO ls_data-ignore.
    APPEND '/.devcontainer.json' TO ls_data-ignore.

    CREATE OBJECT ro_dot_abapgit
      EXPORTING
        is_data = ls_data.

  ENDMETHOD.