  METHOD load_package.

    cl_package_factory=>load_package(
      EXPORTING
        i_package_name             = iv_package_name
        i_force_reload             = abap_true
      IMPORTING
        e_package                  = ri_package
      EXCEPTIONS
        object_not_existing        = 1
        unexpected_error           = 2
        intern_err                 = 3
        no_access                  = 4
        object_locked_and_modified = 5
        OTHERS                     = 6 ).
    IF sy-subrc = 1.
      RETURN.
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

  ENDMETHOD.