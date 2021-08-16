  METHOD checks_adjust.

    warning_overwrite_adjust(
      EXPORTING it_overwrite = is_checks-overwrite
      CHANGING ct_results = ct_results ).

    warning_package_adjust(
      EXPORTING
        io_repo = io_repo
        it_overwrite = is_checks-warning_package
      CHANGING
        ct_results = ct_results ).

  ENDMETHOD.