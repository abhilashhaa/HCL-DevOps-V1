  PROTECTED SECTION.

    CLASS-METHODS render_repo_top_commit_hash
      IMPORTING
        !ii_html        TYPE REF TO zif_abapgit_html
        !io_repo_online TYPE REF TO zcl_abapgit_repo_online
      RAISING
        zcx_abapgit_exception .