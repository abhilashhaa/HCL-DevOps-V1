  METHOD serialize_abap_clif_source.
    rt_source = zcl_abapgit_exit=>get_instance( )->custom_serialize_abap_clif( is_class_key ).
    IF rt_source IS NOT INITIAL.
      RETURN.
    ENDIF.

    TRY.
        rt_source = serialize_abap_new( is_class_key ).
      CATCH cx_sy_dyn_call_error.
        rt_source = serialize_abap_old( is_class_key ).
    ENDTRY.
  ENDMETHOD.