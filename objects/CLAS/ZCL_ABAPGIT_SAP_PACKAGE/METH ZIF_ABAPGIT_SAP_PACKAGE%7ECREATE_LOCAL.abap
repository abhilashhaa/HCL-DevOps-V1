  METHOD zif_abapgit_sap_package~create_local.

    DATA: ls_package TYPE scompkdtln.


    ls_package-devclass  = mv_package.
    ls_package-ctext     = mv_package.
    ls_package-parentcl  = '$TMP'.
    ls_package-dlvunit   = 'LOCAL'.
    ls_package-as4user   = sy-uname.

    create( ls_package ).

  ENDMETHOD.