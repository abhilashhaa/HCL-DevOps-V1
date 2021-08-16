  METHOD display_version_mismatch.

    DATA: lv_version TYPE string.
    DATA: lv_file    TYPE string.

    lv_version = |abapGit version: { zif_abapgit_version=>gc_abap_version }|.
    IF mv_filename IS NOT INITIAL.
      lv_file = |File: { mv_filename }|.
    ENDIF.

    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'abapGit XML version mismatch'
        txt1  = 'abapGit XML version mismatch'
        txt2  = 'See https://docs.abapgit.org/other-xml-mismatch.html'
        txt3  = lv_version
        txt4  = lv_file.

    IF mv_filename IS INITIAL.
      zcx_abapgit_exception=>raise( 'abapGit XML version mismatch' ).
    ELSE.
      zcx_abapgit_exception=>raise( |abapGit XML version mismatch in file { mv_filename }| ).
    ENDIF.

  ENDMETHOD.