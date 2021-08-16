  METHOD zif_abapgit_object~delete.

    DATA: ls_icfservice TYPE icfservice.

    read( IMPORTING es_icfservice = ls_icfservice ).

    IF ls_icfservice IS INITIAL.
      " It seems that the ICF service doesn't exist anymore.
      " But that's ok, because some objects like SAPC manage
      " the lifecycle of its ICF service by itself and already
      " deleted the service.
      RETURN.
    ENDIF.

    IF ls_icfservice-icfparguid CO '0'.
      " not supported by the SAP standard API
      zcx_abapgit_exception=>raise( 'SICF - cannot delete root node, delete node manually' ).
    ENDIF.

    " Delete Application Customizing Data the hard way, as it isn't done by the API.
    " If we wouldn't we would get errors from the API if entrys exist.
    " Transaction SICF does the same.
    DELETE FROM icfapplcust
           WHERE icf_name = ls_icfservice-icf_name
           AND icfparguid = ls_icfservice-icfparguid.

    cl_icf_tree=>if_icf_tree~delete_node(
      EXPORTING
        icfparguid                  = ls_icfservice-icfparguid
      CHANGING
        icf_name                    = ls_icfservice-icf_name
      EXCEPTIONS
        no_virtual_host_delete      = 1
        special_service_error       = 2
        enqueue_error               = 3
        node_not_existing           = 4
        node_has_childs             = 5
        node_is_aliased             = 6
        node_not_in_original_system = 7
        transport_error             = 8
        tadir_error                 = 9
        db_error                    = 10
        no_authority                = 11
        OTHERS                      = 12 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |SICF - error from delete_node. Subrc = { sy-subrc }| ).
    ENDIF.

  ENDMETHOD.