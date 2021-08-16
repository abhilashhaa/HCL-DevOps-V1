  METHOD open_dotabap_homepage.

    cl_gui_frontend_services=>execute(
      EXPORTING document = c_dotabap_homepage
      EXCEPTIONS OTHERS = 1 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Opening page in external browser failed.' ).
    ENDIF.

  ENDMETHOD.