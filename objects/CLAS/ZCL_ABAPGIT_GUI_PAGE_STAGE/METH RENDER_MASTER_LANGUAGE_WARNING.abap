  METHOD render_master_language_warning.

    DATA: ls_dot_abapgit TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ls_dot_abapgit = mo_repo->get_dot_abapgit( )->get_data( ).

    IF ls_dot_abapgit-master_language <> sy-langu.
      ri_html->add( zcl_abapgit_gui_chunk_lib=>render_warning_banner(
                        |Caution: Master language of the repo is '{ ls_dot_abapgit-master_language }', |
                     && |but you're logged on in '{ sy-langu }'| ) ).
    ENDIF.

  ENDMETHOD.