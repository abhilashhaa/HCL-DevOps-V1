  METHOD change_sicf.

    DATA: lt_icfhndlist TYPE icfhndlist,
          lt_existing   TYPE TABLE OF icfhandler,
          ls_icfserdesc TYPE icfserdesc.

    FIELD-SYMBOLS: <ls_existing> LIKE LINE OF lt_existing.


    lt_icfhndlist = to_icfhndlist( it_icfhandler ).

* Do not add handlers if they already exist, it will make the below
* call to SAP standard code raise an exception
    SELECT * FROM icfhandler INTO TABLE lt_existing
      WHERE icf_name = is_icfservice-icf_name.
    LOOP AT lt_existing ASSIGNING <ls_existing>.
      DELETE TABLE lt_icfhndlist FROM <ls_existing>-icfhandler.
    ENDLOOP.

    MOVE-CORRESPONDING is_icfservice TO ls_icfserdesc.

    cl_icf_tree=>if_icf_tree~change_node(
      EXPORTING
        icf_name                  = is_icfservice-orig_name
        icfparguid                = iv_parent
        icfdocu                   = is_icfdocu
        doculang                  = mv_language
        icfhandlst                = lt_icfhndlist
        package                   = iv_package
        application               = space
        icfserdesc                = ls_icfserdesc
        icfactive                 = abap_true
      EXCEPTIONS
        empty_icf_name            = 1
        no_new_virtual_host       = 2
        special_service_error     = 3
        parent_not_existing       = 4
        enqueue_error             = 5
        node_already_existing     = 6
        empty_docu                = 7
        doculang_not_installed    = 8
        security_info_error       = 9
        user_password_error       = 10
        password_encryption_error = 11
        invalid_url               = 12
        invalid_otr_concept       = 13
        formflg401_error          = 14
        handler_error             = 15
        transport_error           = 16
        tadir_error               = 17
        package_not_found         = 18
        wrong_application         = 19
        not_allow_application     = 20
        no_application            = 21
        invalid_icfparguid        = 22
        alt_name_invalid          = 23
        alternate_name_exist      = 24
        wrong_icf_name            = 25
        no_authority              = 26
        OTHERS                    = 27 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |SICF - error from change_node. Subrc = { sy-subrc }| ).
    ENDIF.

  ENDMETHOD.