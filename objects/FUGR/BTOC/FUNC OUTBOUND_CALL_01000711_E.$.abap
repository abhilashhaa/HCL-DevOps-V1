*******************************************************************
*   THIS FILE IS GENERATED BY THE FUNCTION LIBRARY.               *
*   NEVER CHANGE IT MANUALLY, PLEASE!                             *
*******************************************************************
FUNCTION $$UNIT$$ OUTBOUND_CALL_01000711_E

    IMPORTING
       REFERENCE(IM_MATNR) LIKE !EBAN-MATNR
       REFERENCE(IM_WERKS) LIKE !EBAN-WERKS
    EXPORTING
       REFERENCE(EX_APO_ACTIVE) TYPE !XFELD .