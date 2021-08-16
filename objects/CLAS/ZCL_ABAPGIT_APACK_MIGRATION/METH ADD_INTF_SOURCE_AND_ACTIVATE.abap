  METHOD add_intf_source_and_activate.

    DATA: ls_clskey           TYPE seoclskey,
          ls_inactive_object  TYPE dwinactiv,
          lt_inactive_objects TYPE TABLE OF dwinactiv.

    ls_clskey-clsname = c_interface_name.

    add_interface_source( ls_clskey ).

    ls_inactive_object-object   = 'INTF'.
    ls_inactive_object-obj_name = c_interface_name.
    INSERT ls_inactive_object INTO TABLE lt_inactive_objects.

    CALL FUNCTION 'RS_WORKING_OBJECTS_ACTIVATE'
      TABLES
        objects                = lt_inactive_objects
      EXCEPTIONS
        excecution_error       = 1
        cancelled              = 2
        insert_into_corr_error = 3
        OTHERS                 = 4.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from RS_WORKING_OBJECTS_ACTIVATE' ).
    ENDIF.

  ENDMETHOD.