  METHOD zif_abapgit_oo_object_fnc~insert_text_pool.
    DATA: lv_cp TYPE program.

    lv_cp = cl_oo_classname_service=>get_classpool_name( iv_class_name ).

    INSERT TEXTPOOL lv_cp
      FROM it_text_pool
      LANGUAGE iv_language
      STATE iv_state.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from INSERT TEXTPOOL' ).
    ENDIF.

    zcl_abapgit_objects_activation=>add( iv_type = 'REPT'
                                         iv_name = lv_cp ).
  ENDMETHOD.