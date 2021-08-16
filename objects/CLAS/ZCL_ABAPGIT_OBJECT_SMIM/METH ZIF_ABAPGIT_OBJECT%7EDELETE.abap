  METHOD zif_abapgit_object~delete.

    DATA: li_api TYPE REF TO if_mr_api,
          lv_url TYPE string.


    TRY.
        get_url_for_io( IMPORTING ev_url  = lv_url ).
      CATCH zcx_abapgit_not_found.
        RETURN.
    ENDTRY.

    li_api = cl_mime_repository_api=>if_mr_api~get_api( ).
    li_api->delete(
      EXPORTING
        i_url              = lv_url
        i_delete_children  = abap_true
      EXCEPTIONS
        parameter_missing  = 1
        error_occured      = 2
        cancelled          = 3
        permission_failure = 4
        not_found          = 5
        OTHERS             = 6 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from delete' ).
    ENDIF.

  ENDMETHOD.