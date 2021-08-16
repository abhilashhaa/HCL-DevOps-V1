  METHOD a_clfnclasscharc_get_entity.

*    DATA: lx_busi_exception TYPE REF TO /iwbep/cx_mgw_busi_exception.
*
*    TRY.
*        mo_cut->a_clfnclasscharc_get_entity(
*         EXPORTING
*           iv_entity_name          = VALUE #( )
*           iv_entity_set_name      = VALUE #( )
*           iv_source_name          = VALUE #( )
*           it_key_tab              = VALUE #( )
**           io_request_object       = VALUE #( )
**           io_tech_request_context = mo_tech_request_context
**           iv_filter_string        = VALUE #( )
**           it_filter_select_options = VALUE #( )
**           is_paging               = VALUE #( )
**           it_order                = VALUE #( )
*           it_navigation_path      = VALUE #( )
*       ).
**        cl_abap_unit_assert=>fail( 'Exception not raised' ).
*      CATCH /iwbep/cx_mgw_busi_exception INTO lx_busi_exception.
*        IF lx_busi_exception->previous IS NOT INSTANCE OF cx_lo_vchclf_sim_cabn.
*          cl_abap_unit_assert=>fail( 'Invalid exception' ).
*        ENDIF.
*    ENDTRY.
  ENDMETHOD.