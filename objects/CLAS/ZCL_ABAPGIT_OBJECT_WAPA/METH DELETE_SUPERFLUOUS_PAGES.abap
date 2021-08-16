  METHOD delete_superfluous_pages.

    DATA: ls_pagekey TYPE o2pagkey.
    FIELD-SYMBOLS: <ls_local_page> LIKE LINE OF it_local_pages.

    " delete local pages which doesn't exists remotely
    LOOP AT it_local_pages ASSIGNING <ls_local_page>.

      READ TABLE it_remote_pages WITH KEY attributes-pagekey = <ls_local_page>-pagekey
                               TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        " page exists locally but not remotely -> delete

        ls_pagekey-applname = <ls_local_page>-applname.
        ls_pagekey-pagekey = <ls_local_page>-pagekey.

        cl_o2_page=>delete_page_for_application(
          EXPORTING
            p_pagekey           = ls_pagekey
          EXCEPTIONS
            object_not_existing = 1
            error_occured       = 2 ).

        IF sy-subrc <> 0.
          zcx_abapgit_exception=>raise( |Error { sy-subrc } from CL_O2_PAGE=>DELETE_PAGE_FOR_APPLICATION| ).
        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.