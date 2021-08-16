  METHOD update_pinf_usages.
    DATA: lt_current_permissions TYPE tpak_permission_to_use_list,
          li_usage               TYPE REF TO if_package_permission_to_use,
          ls_data_sign           TYPE scomppsign,
          ls_add_permission_data TYPE pkgpermdat,
          lt_handled             TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.
    FIELD-SYMBOLS: <ls_usage_data> LIKE LINE OF it_usage_data.

    " Get the current permissions
    ii_package->get_permissions_to_use(
      IMPORTING
        e_permissions    = lt_current_permissions
      EXCEPTIONS
        object_invalid   = 1
        unexpected_error = 2
        OTHERS           = 3 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    ls_data_sign-err_sever = abap_true.

    " New permissions
    LOOP AT it_usage_data ASSIGNING <ls_usage_data>.
      READ TABLE lt_current_permissions
           WITH KEY table_line->package_interface_name = <ls_usage_data>-intf_name
           INTO li_usage.

      IF sy-subrc = 0 AND li_usage IS BOUND.
        INSERT sy-tabix INTO TABLE lt_handled.

        " Permission already exists, update attributes
        li_usage->set_all_attributes(
          EXPORTING
            i_permission_data     = <ls_usage_data>
            i_data_sign           = ls_data_sign
          EXCEPTIONS
            object_not_changeable = 1
            object_invalid        = 2
            intern_err            = 3
            OTHERS                = 4 ).
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise_t100( ).
        ENDIF.

      ELSE.
        " Permission does not exist yet, add it
        MOVE-CORRESPONDING <ls_usage_data> TO ls_add_permission_data.
        ii_package->add_permission_to_use(
          EXPORTING
            i_pkg_permission_data   = ls_add_permission_data
          EXCEPTIONS
            object_not_changeable   = 1
            object_access_error     = 2
            object_already_existing = 3
            object_invalid          = 4
            unexpected_error        = 5
            OTHERS                  = 6 ).
        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise_t100( ).
        ENDIF.

      ENDIF.

      FREE li_usage.
    ENDLOOP.

    " Delete missing usages
    LOOP AT lt_current_permissions INTO li_usage.
      READ TABLE lt_handled WITH TABLE KEY table_line = sy-tabix TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      li_usage->delete(
        EXCEPTIONS
          object_not_changeable = 1
          object_invalid        = 2
*          deletion_not_allowed  = 3 downport, does not exist in 7.30
          intern_err            = 4
          OTHERS                = 5 ).
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.