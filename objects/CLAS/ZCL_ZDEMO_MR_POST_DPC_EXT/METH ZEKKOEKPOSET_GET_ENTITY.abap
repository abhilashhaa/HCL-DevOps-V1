  method ZEKKOEKPOSET_GET_ENTITY.
    DATA: ls_key_tab TYPE /iwbep/s_mgw_name_value_pair,
lv_ebeln TYPE ebeln,
lv_ebelp TYPE ebelp.

* Get the key property values
READ TABLE it_key_tab INTO ls_key_tab WITH KEY name = 'Ebeln' .
IF sy-subrc = 0.
lv_ebeln = ls_key_tab-value.
ENDIF.

* Get the key property values
READ TABLE it_key_tab INTO ls_key_tab WITH KEY name = 'Ebelp' .
IF sy-subrc = 0.
lv_ebelp = ls_key_tab-value.
ENDIF.

* Select one row
SELECT SINGLE * FROM ZEKKOekpo INTO CORRESPONDING FIELDS OF er_entity
WHERE ebeln = lv_ebeln
AND ebelp = lv_ebelp.
**TRY.
*CALL METHOD SUPER->ZEKKOEKPOSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  endmethod.