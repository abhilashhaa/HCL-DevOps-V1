  METHOD zif_abapgit_object~delete.

* You are reminded that this function model checks for
*  - permissions
*  - locks
*  - connection to transport and correction system
*  - deletion of data model, model relations and all documentation
*  - update of object tree
*  - releasing of lock

    CALL FUNCTION 'RPY_DATAMODEL_DELETE'
      EXPORTING
        model_name       = me->mv_data_model
      EXCEPTIONS
        cancelled        = 1
        permission_error = 2
        not_found        = 3
        is_used          = 4
        OTHERS           = 5.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.


  ENDMETHOD.