  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_GETENTITY_BASE
*&* This class has been generated  on 07.06.2019 15:24:21 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - CL_API_CLFN_CHARACTERI_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA a_clfncharcreffo_get_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcrefforkeydatetyp.
 DATA a_clfncharcrstrc_get_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcrstrcnforkeydate.
 DATA a_clfncharcdescf_get_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcdescforkeydatety.
 DATA a_clfncharcvalue_get_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcvaluedescforkeyd.
 DATA a_clfncharcval01_get_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharcvalueforkeydatet.
 DATA a_clfncharacteri_get_entity TYPE cl_api_clfn_characteri_mpc=>ts_a_clfncharacteristicforkeyd.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcRefForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnCharcRefForKeyDate'.
*     Call the entity set generated method
          a_clfncharcreffo_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
               IMPORTING er_entity          = a_clfncharcreffo_get_entity
                         es_response_context = es_response_context
          ).

        IF a_clfncharcreffo_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfncharcreffo_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcRstrcnForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnCharcRstrcnForKeyDate'.
*     Call the entity set generated method
          a_clfncharcrstrc_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
               IMPORTING er_entity          = a_clfncharcrstrc_get_entity
                         es_response_context = es_response_context
          ).

        IF a_clfncharcrstrc_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfncharcrstrc_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcDescForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnCharcDescForKeyDate'.
*     Call the entity set generated method
          a_clfncharcdescf_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
               IMPORTING er_entity          = a_clfncharcdescf_get_entity
                         es_response_context = es_response_context
          ).

        IF a_clfncharcdescf_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfncharcdescf_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcValueDescForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnCharcValueDescForKeyDate'.
*     Call the entity set generated method
          a_clfncharcvalue_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
               IMPORTING er_entity          = a_clfncharcvalue_get_entity
                         es_response_context = es_response_context
          ).

        IF a_clfncharcvalue_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfncharcvalue_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharcValueForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnCharcValueForKeyDate'.
*     Call the entity set generated method
          a_clfncharcval01_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
               IMPORTING er_entity          = a_clfncharcval01_get_entity
                         es_response_context = es_response_context
          ).

        IF a_clfncharcval01_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfncharcval01_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  A_ClfnCharacteristicForKeyDate
*-------------------------------------------------------------------------*
      WHEN 'A_ClfnCharacteristicForKeyDate'.
*     Call the entity set generated method
          a_clfncharacteri_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
               IMPORTING er_entity          = a_clfncharacteri_get_entity
                         es_response_context = es_response_context
          ).

        IF a_clfncharacteri_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = a_clfncharacteri_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.