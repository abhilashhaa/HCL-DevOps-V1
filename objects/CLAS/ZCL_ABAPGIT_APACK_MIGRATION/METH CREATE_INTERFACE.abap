  METHOD create_interface.

    DATA: ls_interface_properties TYPE vseointerf.

    ls_interface_properties-clsname  = c_interface_name.
    ls_interface_properties-version  = '1'.
    ls_interface_properties-langu    = 'E'.
    ls_interface_properties-descript = 'APACK: Manifest interface'.
    ls_interface_properties-exposure = '2'.
    ls_interface_properties-state    = '1'.
    ls_interface_properties-unicode  = abap_true.

    CALL FUNCTION 'SEO_INTERFACE_CREATE_COMPLETE'
      EXPORTING
        devclass        = '$TMP'
      CHANGING
        interface       = ls_interface_properties
      EXCEPTIONS
        existing        = 1
        is_class        = 2
        db_error        = 3
        component_error = 4
        no_access       = 5
        other           = 6
        OTHERS          = 7.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'Error from SEO_INTERFACE_CREATE_COMPLETE' ).
    ENDIF.

    add_intf_source_and_activate( ).

  ENDMETHOD.