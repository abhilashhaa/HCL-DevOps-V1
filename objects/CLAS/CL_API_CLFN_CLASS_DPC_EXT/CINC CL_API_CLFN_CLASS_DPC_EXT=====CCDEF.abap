*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section
*INTERFACE lif_api_clfn_class_dpc.
*  METHODS a_clfnclasscharc_get_entity
*    IMPORTING
*      !io_super                TYPE REF TO cl_api_clfn_class_dpc OPTIONAL
*      !iv_entity_name          TYPE string
*      !iv_entity_set_name      TYPE string
*      !iv_source_name          TYPE string
*      !it_key_tab              TYPE /iwbep/t_mgw_name_value_pair
*      !io_request_object       TYPE REF TO /iwbep/if_mgw_req_entity OPTIONAL
*      !io_tech_request_context TYPE REF TO /iwbep/if_mgw_req_entity OPTIONAL
*      !it_navigation_path      TYPE /iwbep/t_mgw_navigation_path
*    EXPORTING
*      !er_entity               TYPE cl_api_clfn_class_mpc=>ts_a_clfnclasscharcforkeydatet
*      !es_response_context     TYPE /iwbep/if_mgw_appl_srv_runtime=>ty_s_mgw_response_entity_cntxt
*    RAISING
*      /iwbep/cx_mgw_busi_exception
*      /iwbep/cx_mgw_tech_exception .
*  METHODS a_clfnclasscharc_get_entityset
*    IMPORTING
*      !io_super                 TYPE REF TO cl_api_clfn_class_dpc OPTIONAL
*      !iv_entity_name           TYPE string
*      !iv_entity_set_name       TYPE string
*      !iv_source_name           TYPE string
*      !it_filter_select_options TYPE /iwbep/t_mgw_select_option
*      !is_paging                TYPE /iwbep/s_mgw_paging
*      !it_key_tab               TYPE /iwbep/t_mgw_name_value_pair
*      !it_navigation_path       TYPE /iwbep/t_mgw_navigation_path
*      !it_order                 TYPE /iwbep/t_mgw_sorting_order
*      !iv_filter_string         TYPE string
*      !iv_search_string         TYPE string
*      !io_tech_request_context  TYPE REF TO /iwbep/if_mgw_req_entityset OPTIONAL
*    EXPORTING
*      !et_entityset             TYPE cl_api_clfn_class_mpc=>tt_a_clfnclasscharcforkeydatet
*      !es_response_context      TYPE /iwbep/if_mgw_appl_srv_runtime=>ty_s_mgw_response_context
*    RAISING
*      /iwbep/cx_mgw_busi_exception
*      /iwbep/cx_mgw_tech_exception .
*ENDINTERFACE.