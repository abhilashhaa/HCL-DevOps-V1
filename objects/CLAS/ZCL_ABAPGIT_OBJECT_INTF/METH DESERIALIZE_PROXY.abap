  METHOD deserialize_proxy.

    DATA: lv_transport    TYPE e070use-ordernum,
          li_proxy_object TYPE REF TO if_px_main,
          lv_name         TYPE prx_r3name,
          lx_proxy_fault  TYPE REF TO cx_proxy_fault.

    lv_transport = zcl_abapgit_default_transport=>get_instance(
                                               )->get( )-ordernum.

    lv_name = ms_item-obj_name.

    TRY.
        li_proxy_object = cl_pxn_factory=>create(
                              application  = 'PROXY_UI'
                              display_only = abap_false
                              saveable     = abap_true
                          )->if_pxn_factory~load_by_abap_name(
                              object   = ms_item-obj_type
                              obj_name = lv_name ).

        li_proxy_object->activate(
          EXPORTING
            activate_all     = abap_true
          CHANGING
            transport_number = lv_transport ).

        li_proxy_object->dequeue( ).

      CATCH cx_proxy_fault INTO lx_proxy_fault.
        zcx_abapgit_exception=>raise( iv_text     = |{ lx_proxy_fault->get_text( ) }|
                                      ix_previous = lx_proxy_fault ).
    ENDTRY.

  ENDMETHOD.