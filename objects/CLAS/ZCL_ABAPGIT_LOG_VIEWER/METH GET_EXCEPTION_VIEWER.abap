  METHOD get_exception_viewer.

    DATA:
      lx_abapgit TYPE REF TO zcx_abapgit_exception.

    ASSERT is_log-exception IS BOUND.
    lx_abapgit ?= is_log-exception.

    CREATE OBJECT ro_exception_viewer
      EXPORTING
        ix_error = lx_abapgit.

  ENDMETHOD.