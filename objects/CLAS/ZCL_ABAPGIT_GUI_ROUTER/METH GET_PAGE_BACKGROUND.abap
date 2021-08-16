  METHOD get_page_background.

    CREATE OBJECT ri_page TYPE zcl_abapgit_gui_page_bkg
      EXPORTING
        iv_key = iv_key.

  ENDMETHOD.