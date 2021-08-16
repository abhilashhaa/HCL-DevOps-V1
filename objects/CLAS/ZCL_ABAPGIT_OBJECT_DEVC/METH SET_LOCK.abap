  METHOD set_lock.
    DATA: lv_changeable TYPE abap_bool.

    ii_package->get_changeable( IMPORTING e_changeable = lv_changeable ).
    IF lv_changeable <> iv_lock.
      ii_package->set_changeable(
        EXPORTING
          i_changeable                = iv_lock
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
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise_t100( ).
      ENDIF.
    ENDIF.

    ii_package->set_permissions_changeable(
      EXPORTING
        i_changeable                = iv_lock
* downport, does not exist in 7.30. Let's see if we can get along without it
*        i_suppress_dialog           = abap_true
      EXCEPTIONS
        object_already_changeable   = 1
        object_already_unlocked     = 2
        object_locked_by_other_user = 3
        object_modified             = 4
        object_just_created         = 5
        object_deleted              = 6
        permission_failure          = 7
        object_invalid              = 8
        unexpected_error            = 9
        OTHERS                      = 10 ).
    IF ( sy-subrc = 1 AND iv_lock = abap_true ) OR ( sy-subrc = 2 AND iv_lock = abap_false ).
      " There's no getter to find out beforehand...
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.
  ENDMETHOD.