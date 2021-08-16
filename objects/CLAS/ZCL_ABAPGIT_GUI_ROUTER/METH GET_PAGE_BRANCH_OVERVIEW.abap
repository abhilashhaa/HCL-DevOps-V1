  METHOD get_page_branch_overview.

    DATA: lo_repo TYPE REF TO zcl_abapgit_repo_online,
          lo_page TYPE REF TO zcl_abapgit_gui_page_boverview.


    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    CREATE OBJECT lo_page
      EXPORTING
        io_repo = lo_repo.

    ri_page = lo_page.

  ENDMETHOD.