  METHOD a_clfnclasscharc_get_entity.

    DATA:
      lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
      lt_header                TYPE tihttpnvp,
      lo_request               TYPE REF TO /iwbep/cl_mgw_request.

    TRY.
        TEST-SEAM classcharc_get_entity.
          super->a_clfnclasscharc_get_entity(
            EXPORTING
              iv_entity_name          = iv_entity_name
              iv_entity_set_name      = iv_entity_set_name
              iv_source_name          = iv_source_name
              it_key_tab              = it_key_tab
              io_request_object       = io_request_object
              io_tech_request_context = io_tech_request_context
              it_navigation_path      = it_navigation_path
            IMPORTING
              er_entity               = er_entity
              es_response_context     = es_response_context ).
        END-TEST-SEAM.
      CATCH /iwbep/cx_mgw_busi_exception.

        LOOP AT it_key_tab ASSIGNING FIELD-SYMBOL(<ls_key_tab>).
          APPEND INITIAL LINE TO lt_filter_select_options ASSIGNING FIELD-SYMBOL(<ls_filter_select_option>).
          DATA(lv_name) =  <ls_key_tab>-name.
          TRANSLATE lv_name TO UPPER CASE.
          <ls_filter_select_option>-property = lv_name.
          <ls_filter_select_option>-select_options = VALUE #( ( sign = 'I' option = 'EQ' low = <ls_key_tab>-value ) ).
        ENDLOOP.

        TEST-SEAM classcharc_get_entity_via_set.

          lo_request ?= io_tech_request_context.

          DATA(ls_request_details) = lo_request->get_request_details( ).
          ls_request_details-technical_request-filter_select_options = lt_filter_select_options.

          /iwbep/if_mgw_core_srv_runtime~init_request_context(
            EXPORTING
              is_request_details           = ls_request_details
              it_headers                   = lt_header
            CHANGING
              co_request_context           = lo_request ).

          a_clfnclasscharc_get_entityset(
            EXPORTING
              iv_entity_name           = iv_entity_name
              iv_entity_set_name       = iv_entity_set_name
              iv_source_name           = iv_source_name
              it_filter_select_options = lt_filter_select_options
              is_paging                = VALUE #( )
              it_key_tab               = VALUE #( )
              it_navigation_path       = VALUE #( )
              it_order                 = VALUE #( )
              iv_filter_string         = ''
              iv_search_string         = ''
              io_tech_request_context  = lo_request
            IMPORTING
              et_entityset             = DATA(lt_entityset) ).

        END-TEST-SEAM.

        READ TABLE lt_entityset INDEX 1 INTO er_entity.

    ENDTRY.

  ENDMETHOD.