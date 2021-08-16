  METHOD get.

    DATA: lv_name TYPE cxsltdesc.


    lv_name = ms_item-obj_name.

    cl_o2_api_xsltdesc=>load(
      EXPORTING
        p_xslt_desc        = lv_name
      IMPORTING
        p_obj              = ro_xslt
      EXCEPTIONS
        not_existing       = 1
        permission_failure = 2
        OTHERS             = 3 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from cl_o2_api_xsltdesc=>load' ).
    ENDIF.

  ENDMETHOD.