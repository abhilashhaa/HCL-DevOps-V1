  METHOD get_page_patch.

    DATA: lo_page  TYPE REF TO zcl_abapgit_gui_page_patch,
          lv_key   TYPE zif_abapgit_persistence=>ty_repo-key,
          lt_files TYPE zif_abapgit_definitions=>ty_stage_tt.

    lv_key = mo_repo->get_key( ).
    lt_files = io_stage->get_all( ).

    DELETE lt_files WHERE method <> zif_abapgit_definitions=>c_method-add
                    AND   method <> zif_abapgit_definitions=>c_method-rm.

    CREATE OBJECT lo_page
      EXPORTING
        iv_key   = lv_key
        it_files = lt_files.

    ri_page = lo_page.

  ENDMETHOD.