  METHOD a_clfnclasscharc_get_entityset.
    " Check with raise exception in get_runtime
*    IF enforce_rt_factory_exception( ) = 'NOT_POSSIBLE'.
*      RETURN.
*    ENDIF.
*
*    TRY.
*        mo_cut->a_clfnclasscharc_get_entityset(
*         EXPORTING
*           iv_entity_name          = VALUE #( )
*           iv_entity_set_name      = VALUE #( )
*           iv_source_name          = VALUE #( )
*           it_key_tab              = VALUE #( )
*           iv_filter_string        = VALUE #( )
*           it_filter_select_options = VALUE #( )
*           is_paging               = VALUE #( )
*           it_order                = VALUE #( )
*           it_navigation_path      = VALUE #( )
*           iv_search_string        = VALUE #( )
*       ).
*      CATCH /iwbep/cx_mgw_busi_exception INTO DATA(lx_busi_exc).
*        IF lx_busi_exc->get_msg_container( ) IS INITIAL.
*          cl_abap_unit_assert=>fail( 'Message container not filled' ).
*        ENDIF.
*    ENDTRY.
  ENDMETHOD.