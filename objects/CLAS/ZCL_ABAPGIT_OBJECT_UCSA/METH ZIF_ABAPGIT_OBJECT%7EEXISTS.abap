  METHOD zif_abapgit_object~exists.

    DATA: lv_id          TYPE ty_id,
          lo_persistence TYPE REF TO object.

    lv_id = ms_item-obj_name.

    TRY.
        lo_persistence = get_persistence( lv_id ).

        " Interface IF_UCON_SA_PERSIST and other objects are not present
        " in lower Netweaver realeses. Therefore we have to call them
        " dynamically to be downward comapatible.

        CALL METHOD lo_persistence->('IF_UCON_SA_PERSIST~LOAD')
          EXPORTING
            version  = c_version-active
            language = mv_language.

      CATCH cx_root.
        rv_bool = abap_false.
        RETURN.
    ENDTRY.

    rv_bool = abap_true.

  ENDMETHOD.