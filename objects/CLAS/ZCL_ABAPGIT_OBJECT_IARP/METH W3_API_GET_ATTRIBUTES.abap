  METHOD w3_api_get_attributes.

    ii_resource->get_attributes(
      IMPORTING
        p_attributes     = rs_attributes
      EXCEPTIONS
        object_invalid   = 1
        resource_deleted = 2
        error_occured    = 3
        OTHERS           = 4 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from if_w3_api_resource~get_attributes. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.