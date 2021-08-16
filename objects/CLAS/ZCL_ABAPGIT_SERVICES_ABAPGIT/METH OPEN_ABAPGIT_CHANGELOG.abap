  METHOD open_abapgit_changelog.

    cl_gui_frontend_services=>execute(
      EXPORTING document = c_abapgit_repo && '/blob/master/changelog.txt'
      EXCEPTIONS OTHERS = 1 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Opening page in external browser failed.' ).
    ENDIF.

  ENDMETHOD.