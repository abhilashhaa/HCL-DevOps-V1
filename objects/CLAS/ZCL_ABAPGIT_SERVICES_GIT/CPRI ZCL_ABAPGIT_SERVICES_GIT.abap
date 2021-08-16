  PRIVATE SECTION.
    CLASS-METHODS checkout_commit_build_popup
      IMPORTING
        !it_commits         TYPE zif_abapgit_definitions=>ty_commit_tt
      EXPORTING
        !es_selected_commit TYPE zif_abapgit_definitions=>ty_commit
      CHANGING
        !ct_value_tab       TYPE ty_commit_value_tab_tt
      RAISING
        zcx_abapgit_exception .
