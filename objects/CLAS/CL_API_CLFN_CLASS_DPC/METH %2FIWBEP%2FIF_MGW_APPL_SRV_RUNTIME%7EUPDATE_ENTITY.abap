  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_UPD_ENTITY_BASE
*&* This class has been generated on 12.08.2018 00:15:44 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - CL_API_CLFN_CLASS_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA a_clfnclasstextf_update_entity TYPE cl_api_clfn_class_mpc=>ts_a_clfnclasstextforkeydatety.
 DATA a_clfnclasskeywo_update_entity TYPE cl_api_clfn_class_mpc=>ts_a_clfnclasskeywordforkeydat.
 DATA a_clfnclassforke_update_entity TYPE cl_api_clfn_class_mpc=>ts_a_clfnclassforkeydatetype.
 DATA a_clfnclassdescf_update_entity TYPE cl_api_clfn_class_mpc=>ts_a_clfnclassdescforkeydatety.
 DATA a_clfnclasscharc_update_entity TYPE cl_api_clfn_class_mpc=>ts_a_clfnclasscharcforkeydatet.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnClassTextForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnClassTextForKeyDate'.
*     Call the entity set generated method
          a_clfnclasstextf_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = a_clfnclasstextf_update_entity
          ).
       IF a_clfnclasstextf_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfnclasstextf_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnClassKeywordForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnClassKeywordForKeyDate'.
*     Call the entity set generated method
          a_clfnclasskeywo_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = a_clfnclasskeywo_update_entity
          ).
       IF a_clfnclasskeywo_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfnclasskeywo_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnClassForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnClassForKeyDate'.
*     Call the entity set generated method
          a_clfnclassforke_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = a_clfnclassforke_update_entity
          ).
       IF a_clfnclassforke_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfnclassforke_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnClassDescForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnClassDescForKeyDate'.
*     Call the entity set generated method
          a_clfnclassdescf_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = a_clfnclassdescf_update_entity
          ).
       IF a_clfnclassdescf_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfnclassdescf_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnClassCharcForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnClassCharcForKeyDate'.
*     Call the entity set generated method
          a_clfnclasscharc_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = a_clfnclasscharc_update_entity
          ).
       IF a_clfnclasscharc_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfnclasscharc_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~update_entity(
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