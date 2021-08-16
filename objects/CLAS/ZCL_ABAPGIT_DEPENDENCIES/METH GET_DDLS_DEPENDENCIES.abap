  METHOD get_ddls_dependencies.

    DATA: lt_ddls_name TYPE TABLE OF ddsymtab,
          ls_ddls_name TYPE ddsymtab.

    ls_ddls_name-name = iv_ddls_name.
    INSERT ls_ddls_name INTO TABLE lt_ddls_name.

    PERFORM ('DDLS_GET_DEP') IN PROGRAM ('RADMASDL')
                             TABLES lt_ddls_name rt_dependency.

  ENDMETHOD.