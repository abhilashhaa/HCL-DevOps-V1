  METHOD zif_abapgit_object~delete.

    DATA:
      lv_object      TYPE sproxhdr-object,
      lv_obj_name    TYPE sproxhdr-obj_name,
      lv_return_code TYPE i,
      lt_log         TYPE sprx_log_t.

    get_object_and_name(
      IMPORTING
        ev_object   = lv_object
        ev_obj_name = lv_obj_name ).

    cl_proxy_data=>delete_single_proxy(
       EXPORTING
         object           = lv_object
         obj_name         = lv_obj_name
       CHANGING
         c_return_code    = lv_return_code
         ct_log           = lt_log ).
    IF lv_return_code <> 0.
      zcx_abapgit_exception=>raise( 'SPRX: Error from DELETE_SINGLE_PROXY' ).
    ENDIF.

  ENDMETHOD.