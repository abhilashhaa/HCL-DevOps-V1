  METHOD zif_abapgit_object~delete.

    DATA: lx_error      TYPE REF TO cx_enh_root,
          li_enh_object TYPE REF TO if_enh_object.

    TRY.
        li_enh_object = cl_enh_factory=>load_enhancement_composite(
          name = mv_composite_id
          lock = abap_true ).

        li_enh_object->delete( ).
        li_enh_object->save( ).
        li_enh_object->unlock( ).

      CATCH cx_enh_root INTO lx_error.
        zcx_abapgit_exception=>raise( lx_error->get_text( ) ).
    ENDTRY.

  ENDMETHOD.