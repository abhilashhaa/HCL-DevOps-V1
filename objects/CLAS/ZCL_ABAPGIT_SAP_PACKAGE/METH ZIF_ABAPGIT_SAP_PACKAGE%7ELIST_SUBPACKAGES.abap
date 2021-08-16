  METHOD zif_abapgit_sap_package~list_subpackages.

    DATA: lt_list     LIKE rt_list.

    SELECT devclass FROM tdevc
      INTO TABLE lt_list
      WHERE parentcl = mv_package
      ORDER BY PRIMARY KEY.               "#EC CI_SUBRC "#EC CI_GENBUFF

    rt_list = lt_list.
    WHILE lines( lt_list ) > 0.

      SELECT devclass FROM tdevc
        INTO TABLE lt_list
        FOR ALL ENTRIES IN lt_list
        WHERE parentcl = lt_list-table_line
        ORDER BY PRIMARY KEY.             "#EC CI_SUBRC "#EC CI_GENBUFF
      APPEND LINES OF lt_list TO rt_list.

    ENDWHILE.

  ENDMETHOD.