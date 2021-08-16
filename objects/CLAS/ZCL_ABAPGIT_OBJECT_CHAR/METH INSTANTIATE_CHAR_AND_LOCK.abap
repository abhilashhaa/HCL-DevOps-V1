  METHOD instantiate_char_and_lock.

    DATA: lv_new  TYPE abap_bool,
          lv_name TYPE cls_attribute_name.


    SELECT SINGLE name FROM cls_attribute INTO lv_name WHERE name = ms_item-obj_name.
    lv_new = boolc( sy-subrc <> 0 ).
    lv_name = ms_item-obj_name.

    TRY.
        CREATE OBJECT ro_char
          EXPORTING
            im_name             = lv_name
            im_type_group       = iv_type_group
            im_new              = lv_new
            im_activation_state = iv_activation_state.
      CATCH cx_pak_invalid_data
          cx_pak_not_authorized
          cx_pak_invalid_state
          cx_pak_wb_object_locked.
        zcx_abapgit_exception=>raise( 'Error while instantiating CL_CLS_ATTRIBUTE' ).
    ENDTRY.

    IF lv_new = abap_false.
      TRY.
          ro_char->if_pak_wb_object~lock_and_refresh( ).
        CATCH cx_pak_invalid_data
            cx_pak_not_authorized
            cx_pak_invalid_state
            cx_pak_wb_object_locked.
          zcx_abapgit_exception=>raise( |Could not aquire lock, CHAR { lv_name }| ).
      ENDTRY.
    ENDIF.

  ENDMETHOD.