  METHOD check_language.

    DATA lv_master_language TYPE spras.

    " assumes find_remote_dot_abapgit has been called before
    lv_master_language = get_dot_abapgit( )->get_master_language( ).

    IF lv_master_language <> sy-langu.
      zcx_abapgit_exception=>raise( |Current login language |
                                 && |'{ zcl_abapgit_convert=>conversion_exit_isola_output( sy-langu ) }'|
                                 && | does not match master language |
                                 && |'{ zcl_abapgit_convert=>conversion_exit_isola_output( lv_master_language ) }'.|
                                 && | Run 'Advanced' > 'Open in master language'| ).
    ENDIF.

  ENDMETHOD.