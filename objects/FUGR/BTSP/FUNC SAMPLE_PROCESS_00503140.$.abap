*******************************************************************
*   THIS FILE IS GENERATED BY THE FUNCTION LIBRARY.               *
*   NEVER CHANGE IT MANUALLY, PLEASE!                             *
*******************************************************************
FUNCTION $$UNIT$$ SAMPLE_PROCESS_00503140

    IMPORTING
       REFERENCE(IV_ITEM_GUID) TYPE !IAOM_EXT_OBJECT_ID
       REFERENCE(IV_MEINS) TYPE !MEINS OPTIONAL
       REFERENCE(IV_GJAHR) TYPE !GJAHR OPTIONAL
    EXPORTING
       REFERENCE(ES_COBL) TYPE !COBL
    EXCEPTIONS
       !NOT_IAOM_RELEVANT
       !ERROR_OCCURRED .