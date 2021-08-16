  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 30.08.2017 14:38:03 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - CL_API_CLFN_PRODUCT_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA a_productclass_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productclasstype.
 DATA a_productclass01_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productclasscharctype.
 DATA a_productdescrip_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productdescriptiontype.
 DATA a_productcharc01_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productcharcvaluetype.
 DATA a_productplant_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productplanttype.
 DATA a_productplant01_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productplantprocurementty.
 DATA a_productcharc_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productcharctype.
 DATA a_productsalesde_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productsalesdeliverytype.
 DATA a_productsales01_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productsalestaxtype.
 DATA a_clfnproduct_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_clfnproducttype.
 DATA a_productstorage_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productstoragelocationtyp.
 DATA a_productsupplyp_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productsupplyplanningtype.
 DATA a_clfnclassforke_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_clfnclassforkeydatetype.
 DATA a_productworksch_create_entity TYPE cl_api_clfn_product_mpc=>ts_a_productworkschedulingtype.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductClass
*-------------------------------------------------------------------------*
     WHEN 'A_ProductClass'.
*     Call the entity set generated method
    a_productclass_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productclass_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productclass_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductClassCharc
*-------------------------------------------------------------------------*
     WHEN 'A_ProductClassCharc'.
*     Call the entity set generated method
    a_productclass01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productclass01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productclass01_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductDescription
*-------------------------------------------------------------------------*
     WHEN 'A_ProductDescription'.
*     Call the entity set generated method
    a_productdescrip_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productdescrip_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productdescrip_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductCharcValue
*-------------------------------------------------------------------------*
     WHEN 'A_ProductCharcValue'.
*     Call the entity set generated method
    a_productcharc01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productcharc01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productcharc01_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductPlant
*-------------------------------------------------------------------------*
     WHEN 'A_ProductPlant'.
*     Call the entity set generated method
    a_productplant_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productplant_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productplant_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductPlantProcurement
*-------------------------------------------------------------------------*
     WHEN 'A_ProductPlantProcurement'.
*     Call the entity set generated method
    a_productplant01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productplant01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productplant01_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductCharc
*-------------------------------------------------------------------------*
     WHEN 'A_ProductCharc'.
*     Call the entity set generated method
    a_productcharc_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productcharc_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productcharc_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductSalesDelivery
*-------------------------------------------------------------------------*
     WHEN 'A_ProductSalesDelivery'.
*     Call the entity set generated method
    a_productsalesde_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productsalesde_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productsalesde_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductSalesTax
*-------------------------------------------------------------------------*
     WHEN 'A_ProductSalesTax'.
*     Call the entity set generated method
    a_productsales01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productsales01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productsales01_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnProduct
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnProduct'.
*     Call the entity set generated method
    a_clfnproduct_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_clfnproduct_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfnproduct_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductStorageLocation
*-------------------------------------------------------------------------*
     WHEN 'A_ProductStorageLocation'.
*     Call the entity set generated method
    a_productstorage_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productstorage_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productstorage_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductSupplyPlanning
*-------------------------------------------------------------------------*
     WHEN 'A_ProductSupplyPlanning'.
*     Call the entity set generated method
    a_productsupplyp_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productsupplyp_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productsupplyp_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnClassForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnClassForKeyDate'.
*     Call the entity set generated method
    a_clfnclassforke_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_clfnclassforke_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfnclassforke_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ProductWorkScheduling
*-------------------------------------------------------------------------*
     WHEN 'A_ProductWorkScheduling'.
*     Call the entity set generated method
    a_productworksch_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = a_productworksch_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_productworksch_create_entity
      CHANGING
        cr_data = er_entity
   ).

  when others.
    super->/iwbep/if_mgw_appl_srv_runtime~create_entity(
       EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         io_data_provider   = io_data_provider
         it_key_tab = it_key_tab
         it_navigation_path = it_navigation_path
      IMPORTING
        er_entity = er_entity
  ).
ENDCASE.
  endmethod.