  METHOD create_new_page.

    cl_o2_api_pages=>create_new_page(
      EXPORTING
        p_pageattrs = is_page_attributes
      IMPORTING
        p_page      = ro_page
      EXCEPTIONS
        object_already_exists = 1
        invalid_name          = 2
        error_occured         = 3
        o2appl_not_existing   = 4
        OTHERS                = 5 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error { sy-subrc } from CL_O2_API_PAGES=>CREATE_NEW_PAGE| ).
    ENDIF.

  ENDMETHOD.