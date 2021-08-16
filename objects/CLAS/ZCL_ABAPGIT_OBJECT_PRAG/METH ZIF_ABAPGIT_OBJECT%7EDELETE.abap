  METHOD zif_abapgit_object~delete.

    DATA: lo_pragma TYPE REF TO cl_abap_pragma.

    TRY.
        lo_pragma = cl_abap_pragma=>get_ref( ms_item-obj_name ).

        lo_pragma->delete( ).

      CATCH cx_abap_pragma_not_exists.
        _raise_pragma_not_exists( ).
      CATCH cx_abap_pragma_enqueue.
        _raise_pragma_enqueue( ).
    ENDTRY.

  ENDMETHOD.