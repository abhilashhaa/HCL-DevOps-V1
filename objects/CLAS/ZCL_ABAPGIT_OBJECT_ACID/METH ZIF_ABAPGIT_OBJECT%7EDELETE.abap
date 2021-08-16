  METHOD zif_abapgit_object~delete.

    DATA: lo_aab TYPE REF TO cl_aab_id.


    lo_aab = create_object( ).
    lo_aab->enqueue( ).
    lo_aab->delete(
      EXCEPTIONS
        prop_error       = 1
        propt_error      = 2
        act_error        = 3
        cts_error        = 4
        cts_devclass     = 5
        id_not_found     = 6
        no_authorization = 7
        id_still_used    = 8
        where_used_error = 9
        OTHERS           = 10 ).
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error deleting ACID object' ).
    ENDIF.
    lo_aab->dequeue( ).

  ENDMETHOD.