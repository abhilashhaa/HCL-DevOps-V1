  METHOD poheaderset_get_entity.
DATA : ls_key_tab LIKE LINE OF it_key_tab,
lv_ebeln TYPE ekko-ebeln,
lv_bukrs type ekko-bukrs.

* IT_KEY_TAB has key name and value
READ TABLE it_key_tab INTO ls_key_tab
WITH KEY name = 'Ebeln'. " Case sensitive
IF sy-subrc EQ 0.
lv_ebeln = ls_key_tab-value.
ENDIF.

READ TABLE it_key_tab INTO ls_key_tab
WITH KEY name = 'Bukrs'. " Case sensitive
IF sy-subrc EQ 0.
lv_bukrs = ls_key_tab-value.
ENDIF.
* Select one PO entry
SELECT SINGLE * FROM ekko INTO CORRESPONDING FIELDS OF er_entity
WHERE ebeln = lv_ebeln
and bukrs = lv_bukrs .

ENDMETHOD.