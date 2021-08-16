  METHOD zif_abapgit_object~delete.

    DATA: li_srfc_persist TYPE REF TO if_wb_object_persist,
          lx_error        TYPE REF TO cx_root,
          lv_text         TYPE string.


    IF zif_abapgit_object~exists( ) = abap_false.
* the SRFC might already have been deleted with the function module
      RETURN.
    ENDIF.

    TRY.
        CREATE OBJECT li_srfc_persist TYPE ('CL_UCONRFC_OBJECT_PERSIST').

        li_srfc_persist->delete( p_object_key = |{ ms_item-obj_name }|
                                 p_version    = 'A' ).

      CATCH cx_root INTO lx_error.
        lv_text = lx_error->get_text( ).
        zcx_abapgit_exception=>raise( lv_text ).
    ENDTRY.

  ENDMETHOD.