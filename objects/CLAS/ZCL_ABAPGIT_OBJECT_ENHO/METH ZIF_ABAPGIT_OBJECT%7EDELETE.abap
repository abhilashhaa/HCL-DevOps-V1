  METHOD zif_abapgit_object~delete.

    DATA: lv_enh_id     TYPE enhname,
          li_enh_object TYPE REF TO if_enh_object.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    lv_enh_id = ms_item-obj_name.
    TRY.
        li_enh_object = cl_enh_factory=>get_enhancement(
          enhancement_id = lv_enh_id
          lock           = abap_true ).
        li_enh_object->delete( ).
        li_enh_object->save( run_dark = abap_true ).
        li_enh_object->unlock( ).
      CATCH cx_enh_root.
        zcx_abapgit_exception=>raise( 'Error deleting ENHO' ).
    ENDTRY.

  ENDMETHOD.