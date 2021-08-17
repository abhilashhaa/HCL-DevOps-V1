  method POLINEITEMSET_GET_ENTITYSET.
DATA: ls_key_tab TYPE /iwbep/s_mgw_name_value_pair,
lv_ebeln TYPE ebeln.

* Get the key property values
READ TABLE it_key_tab WITH KEY name = 'Ebeln' INTO ls_key_tab.
IF sy-subrc = 0.
lv_ebeln = ls_key_tab-value.
ENDIF.

IF lv_ebeln IS NOT INITIAL.

SELECT * FROM ekpo INTO CORRESPONDING FIELDS OF TABLE et_entityset
WHERE ebeln = lv_ebeln.
ELSE.

SELECT * UP TO 10 ROWS FROM ekpo INTO CORRESPONDING FIELDS OF TABLE et_entityset.

ENDIF.
  endmethod.