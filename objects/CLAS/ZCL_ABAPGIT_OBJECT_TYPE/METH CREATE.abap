  METHOD create.

    DATA: lv_progname  TYPE reposrc-progname,
          lv_typegroup TYPE rsedd0-typegroup.


    lv_typegroup = ms_item-obj_name.

    CALL FUNCTION 'RS_DD_TYGR_INSERT_SOURCES'
      EXPORTING
        typegroupname        = lv_typegroup
        ddtext               = iv_ddtext
        corrnum              = ''
        devclass             = iv_devclass
      TABLES
        source               = it_source
      EXCEPTIONS
        already_exists       = 1
        not_executed         = 2
        permission_failure   = 3
        object_not_specified = 4
        illegal_name         = 5
        OTHERS               = 6.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from RS_DD_TYGR_INSERT_SOURCES' ).
    ENDIF.

    CONCATENATE c_prefix lv_typegroup INTO lv_progname.
    UPDATE progdir SET uccheck = abap_true
      WHERE name = lv_progname.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error setting uccheck' ).
    ENDIF.

  ENDMETHOD.