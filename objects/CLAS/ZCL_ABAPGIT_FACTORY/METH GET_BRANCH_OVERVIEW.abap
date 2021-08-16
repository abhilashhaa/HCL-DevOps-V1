  METHOD get_branch_overview.

    CREATE OBJECT ri_branch_overview
      TYPE zcl_abapgit_branch_overview
      EXPORTING
        io_repo = io_repo.

  ENDMETHOD.