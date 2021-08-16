  METHOD zif_abapgit_oo_object_fnc~delete.
    CALL FUNCTION 'SEO_CLASS_DELETE_COMPLETE'
      EXPORTING
        clskey       = is_deletion_key
      EXCEPTIONS
        not_existing = 1
        is_interface = 2
        db_error     = 3
        no_access    = 4
        other        = 5
        OTHERS       = 6.
    IF sy-subrc = 1.
* ignore deletion of objects that does not exist
* this can happen when the SXCI object is deleted before the implementing CLAS
      RETURN.
    ELSEIF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from SEO_CLASS_DELETE_COMPLETE. Subrc = { sy-subrc }| ).
    ENDIF.
  ENDMETHOD.