  METHOD zif_abapgit_sap_package~create.

    DATA: lv_err     TYPE string,
          li_package TYPE REF TO if_package,
          ls_package LIKE is_package.


    ASSERT NOT is_package-devclass IS INITIAL.

    cl_package_factory=>load_package(
      EXPORTING
        i_package_name             = is_package-devclass
      EXCEPTIONS
        object_not_existing        = 1
        unexpected_error           = 2
        intern_err                 = 3
        no_access                  = 4
        object_locked_and_modified = 5 ).
    IF sy-subrc = 0.
      " Package already exists. We assume this is fine. Its properties might be changed later at
      " DEVC deserialization.
      RETURN.
    ENDIF.

    ls_package = is_package.

    " Set software component to 'HOME' if none is set at this point.
    " Otherwise SOFTWARE_COMPONENT_INVALID will be raised.
    IF ls_package-dlvunit IS INITIAL.
      ls_package-dlvunit = 'HOME'.
    ENDIF.

    cl_package_factory=>create_new_package(
      EXPORTING
        i_reuse_deleted_object     = abap_true
*        i_suppress_dialog          = abap_true " does not exist in 730
      IMPORTING
        e_package                  = li_package
      CHANGING
        c_package_data             = ls_package
      EXCEPTIONS
        object_already_existing    = 1
        object_just_created        = 2
        not_authorized             = 3
        wrong_name_prefix          = 4
        undefined_name             = 5
        reserved_local_name        = 6
        invalid_package_name       = 7
        short_text_missing         = 8
        software_component_invalid = 9
        layer_invalid              = 10
        author_not_existing        = 11
        component_not_existing     = 12
        component_missing          = 13
        prefix_in_use              = 14
        unexpected_error           = 15
        intern_err                 = 16
        no_access                  = 17
*        invalid_translation_depth  = 18
*        wrong_mainpack_value       = 19
*        superpackage_invalid       = 20
*        error_in_cts_checks        = 21
        OTHERS                     = 18 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Package { is_package-devclass } could not be created| ).
    ENDIF.

    li_package->save(
*      EXPORTING
*        i_suppress_dialog     = abap_true    " Controls whether popups can be transmitted
      EXCEPTIONS
        object_invalid        = 1
        object_not_changeable = 2
        cancelled_in_corr     = 3
        permission_failure    = 4
        unexpected_error      = 5
        intern_err            = 6
        OTHERS                = 7 ).
    IF sy-subrc <> 0.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_err.

      " Here we have to delete the package,
      " otherwise it would remain in the memory
      " and cannot created again in this session.
      li_package->delete(
        EXCEPTIONS
          object_not_empty      = 1
          object_not_changeable = 2
          object_invalid        = 3
          intern_err            = 4
          OTHERS                = 5 ).

      zcx_abapgit_exception=>raise( lv_err ).

    ENDIF.

    li_package->set_changeable( abap_false ).

  ENDMETHOD.