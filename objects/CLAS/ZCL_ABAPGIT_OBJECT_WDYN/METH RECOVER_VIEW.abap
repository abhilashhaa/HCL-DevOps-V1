  METHOD recover_view.

    DATA: ls_key    TYPE wdy_md_view_key,
          lv_corrnr TYPE trkorr,
          ls_delta  TYPE svrs2_xversionable_object.


    ls_delta = delta_view( is_view ).
    ls_key-component_name = is_view-definition-component_name.
    ls_key-view_name      = is_view-definition-view_name.

    TRY.
        cl_wdy_md_abstract_view=>recover_version(
          EXPORTING
            view_key = ls_key
            delta    = ls_delta-wdyv
          CHANGING
            corrnr   = lv_corrnr ).
      CATCH cx_wdy_md_exception.
        zcx_abapgit_exception=>raise( 'error recovering version of abstract view' ).
    ENDTRY.

  ENDMETHOD.