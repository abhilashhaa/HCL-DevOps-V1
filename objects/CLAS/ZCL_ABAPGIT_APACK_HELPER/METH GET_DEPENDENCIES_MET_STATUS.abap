  METHOD get_dependencies_met_status.

    DATA: lt_installed_packages TYPE zif_abapgit_apack_definitions=>tt_descriptor,
          ls_installed_package  TYPE zif_abapgit_apack_definitions=>ty_descriptor,
          ls_dependecy          TYPE zif_abapgit_apack_definitions=>ty_dependency,
          ls_dependecy_popup    TYPE ty_dependency_status.

    IF it_dependencies IS INITIAL.
      RETURN.
    ENDIF.

    lt_installed_packages = get_installed_packages( ).

    LOOP AT it_dependencies INTO ls_dependecy.
      CLEAR: ls_dependecy_popup.

      MOVE-CORRESPONDING ls_dependecy TO ls_dependecy_popup.

      READ TABLE lt_installed_packages INTO ls_installed_package
        WITH KEY group_id    = ls_dependecy-group_id
                 artifact_id = ls_dependecy-artifact_id.
      IF sy-subrc <> 0.
        ls_dependecy_popup-met = zif_abapgit_definitions=>gc_no.
      ELSE.
        TRY.
            zcl_abapgit_version=>check_dependant_version( is_current   = ls_installed_package-sem_version
                                                          is_dependant = ls_dependecy-sem_version ).
            ls_dependecy_popup-met = zif_abapgit_definitions=>gc_yes.
          CATCH zcx_abapgit_exception.
            ls_dependecy_popup-met = zif_abapgit_definitions=>gc_partial.
        ENDTRY.
      ENDIF.

      INSERT ls_dependecy_popup INTO TABLE rt_status.

    ENDLOOP.

  ENDMETHOD.