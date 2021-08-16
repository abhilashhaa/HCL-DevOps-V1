  METHOD zif_abapgit_object~delete.

    DATA: li_package TYPE REF TO if_package,
          lv_package TYPE devclass.

    " Package deletion is a bit tricky. A package can only be deleted if there are no objects
    " contained in it. This includes subpackages, so first the leaf packages need to be deleted.
    " Unfortunately deleted objects that are still contained in an unreleased transport request
    " also count towards the contained objects counter.
    " -> Currently we delete only empty packages
    "
    " If objects are deleted, the TADIR entry is deleted when the transport request is released.
    " So before we can delete the package, the transport which deletes the objects
    " in the package has to be released.

    lv_package = ms_item-obj_name.

    IF is_empty( lv_package ) = abap_true.

      li_package = load_package( lv_package ).

      IF li_package IS NOT BOUND.
        RETURN.
      ENDIF.

      TRY.
          CALL METHOD li_package->('SET_CHANGEABLE')
            EXPORTING
              i_changeable                = abap_true
              i_suppress_dialog           = abap_true " Parameter missing in 702
            EXCEPTIONS
              object_locked_by_other_user = 1
              permission_failure          = 2
              object_already_changeable   = 3
              object_already_unlocked     = 4
              object_just_created         = 5
              object_deleted              = 6
              object_modified             = 7
              object_not_existing         = 8
              object_invalid              = 9
              unexpected_error            = 10
              OTHERS                      = 11.

        CATCH cx_root.
          li_package->set_changeable(
            EXPORTING
              i_changeable                = abap_true
            EXCEPTIONS
              object_locked_by_other_user = 1
              permission_failure          = 2
              object_already_changeable   = 3
              object_already_unlocked     = 4
              object_just_created         = 5
              object_deleted              = 6
              object_modified             = 7
              object_not_existing         = 8
              object_invalid              = 9
              unexpected_error            = 10
              OTHERS                      = 11 ).
      ENDTRY.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

      TRY.
          CALL METHOD li_package->('DELETE')
            EXPORTING
              i_suppress_dialog     = abap_true  " Parameter missing in 702
            EXCEPTIONS
              object_not_empty      = 1
              object_not_changeable = 2
              object_invalid        = 3
              intern_err            = 4
              OTHERS                = 5.

        CATCH cx_root.

          li_package->delete(
            EXCEPTIONS
              object_not_empty      = 1
              object_not_changeable = 2
              object_invalid        = 3
              intern_err            = 4
              OTHERS                = 5 ).

      ENDTRY.

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

      li_package->save(
        EXPORTING
          i_suppress_dialog     = abap_true
        EXCEPTIONS
          object_invalid        = 1
          object_not_changeable = 2
          cancelled_in_corr     = 3
          permission_failure    = 4
          unexpected_error      = 5
          intern_err            = 6
          OTHERS                = 7 ).

      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.

    ENDIF.

  ENDMETHOD.