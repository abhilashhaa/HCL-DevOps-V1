  METHOD load_db.

* method cl_proxy_db=>load_by_abap_name does not exist in lower releases

    DATA: lt_packages TYPE prx_t_namespace_package,
          ls_package  LIKE LINE OF lt_packages,
          ls_hdr      TYPE prx_s_proxy_hdr,
          lv_package  TYPE tadir-devclass,
          lt_ids      TYPE prx_ids.

    cl_proxy_query=>get_hdr_by_abap_name(
      EXPORTING
        object   = mv_object
        obj_name = mv_obj_name
      IMPORTING
        hdr      = ls_hdr ).
    APPEND ls_hdr-id TO lt_ids.

    IF ls_hdr-gen_appl = 'WEBSERVICES'.
      cl_proxy_utils=>get_package(
        EXPORTING
          object   = mv_object
          obj_name = mv_obj_name
        RECEIVING
          rval     = lv_package
        EXCEPTIONS
          OTHERS   = 0 ).

      ls_package-namespace = ls_hdr-esr_nspce.
      ls_package-prefix    = ls_hdr-prefix.
      ls_package-package   = lv_package.
      APPEND ls_package TO lt_packages.
    ENDIF.

    rs_data = cl_proxy_db=>load(
      inactive               = abap_false
      ids                    = lt_ids
      generating_application = ls_hdr-gen_appl
      packages               = lt_packages ).

  ENDMETHOD.