  method POLINEITEMSET_GET_ENTITY.
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
SELECT SINGLE * FROM ekpo INTO CORRESPONDING FIELDS OF er_entity
WHERE ebeln = lv_ebeln
AND ebelp = lv_ebelp.
  endmethod.