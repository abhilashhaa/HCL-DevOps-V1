  METHOD zif_abapgit_object~delete.

    DATA: lo_aab TYPE REF TO cl_aab_variant.

    lo_aab = create_object( ).
    lo_aab->enqueue( ).
    lo_aab->delete(
      EXCEPTIONS
        var_not_found    = 1
        prop_error       = 2
        propt_error      = 3
        var_id_error     = 4
        no_authorization = 5
        cts_error        = 6
        cts_devclass     = 7
        OTHERS           = 8 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error deleting AVAR { ms_item-obj_name }| ).
    ENDIF.
    lo_aab->dequeue( ).

  ENDMETHOD.