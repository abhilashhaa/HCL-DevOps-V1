  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 07.06.2019 15:24:21 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - CL_API_CLFN_CHARACTERI_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA a_clfncharcval01_create_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcvalueforkeydatet.
 DATA a_clfncharacteri_create_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharacteristicforkeyd.
 DATA a_clfncharcvalue_create_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcvaluedescforkeyd.
 DATA a_clfncharcrstrc_create_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcrstrcnforkeydate.
 DATA a_clfncharcdescf_create_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcdescforkeydatety.
 DATA a_clfncharcreffo_create_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcrefforkeydatetyp.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcValueForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnCharcValueForKeyDate'.
*     Call the entity set generated method
    a_clfncharcval01_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
         IMPORTING er_entity          = a_clfncharcval01_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfncharcval01_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharacteristicForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnCharacteristicForKeyDate'.
*     Call the entity set generated method
    a_clfncharacteri_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
         IMPORTING er_entity          = a_clfncharacteri_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfncharacteri_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcValueDescForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnCharcValueDescForKeyDate'.
*     Call the entity set generated method
    a_clfncharcvalue_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
         IMPORTING er_entity          = a_clfncharcvalue_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfncharcvalue_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcRstrcnForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnCharcRstrcnForKeyDate'.
*     Call the entity set generated method
    a_clfncharcrstrc_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
         IMPORTING er_entity          = a_clfncharcrstrc_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfncharcrstrc_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcDescForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnCharcDescForKeyDate'.
*     Call the entity set generated method
    a_clfncharcdescf_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
         IMPORTING er_entity          = a_clfncharcdescf_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfncharcdescf_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcRefForKeyDate
*-------------------------------------------------------------------------*
     WHEN 'A_ClfnCharcRefForKeyDate'.
*     Call the entity set generated method
    a_clfncharcreffo_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
         IMPORTING er_entity          = a_clfncharcreffo_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = a_clfncharcreffo_create_entity
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