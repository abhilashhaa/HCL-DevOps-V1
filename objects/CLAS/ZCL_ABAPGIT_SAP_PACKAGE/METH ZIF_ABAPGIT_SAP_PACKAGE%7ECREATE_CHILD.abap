  METHOD zif_abapgit_sap_package~create_child.

    DATA: li_parent TYPE REF TO if_package,
          ls_child  TYPE scompkdtln.


    cl_package_factory=>load_package(
      EXPORTING
        i_package_name             = mv_package
      IMPORTING
        e_package                  = li_parent
      EXCEPTIONS
        object_not_existing        = 1
        unexpected_error           = 2
        intern_err                 = 3
        no_access                  = 4
        object_locked_and_modified = 5 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error reading parent package' ).
    ENDIF.

    ls_child-devclass  = iv_child.
    ls_child-dlvunit   = li_parent->software_component.
    ls_child-component = li_parent->application_component.
    ls_child-ctext     = iv_child.
    ls_child-parentcl  = mv_package.
    ls_child-pdevclass = li_parent->transport_layer.
    ls_child-as4user   = sy-uname.

    create( ls_child ).

  ENDMETHOD.