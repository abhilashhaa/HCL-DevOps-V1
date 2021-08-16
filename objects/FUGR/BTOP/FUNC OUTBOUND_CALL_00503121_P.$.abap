*******************************************************************
*   THIS FILE IS GENERATED BY THE FUNCTION LIBRARY.               *
*   NEVER CHANGE IT MANUALLY, PLEASE!                             *
*******************************************************************
FUNCTION $$UNIT$$ OUTBOUND_CALL_00503121_P

    IMPORTING
       VALUE(I_VBAK) LIKE !VBAK STRUCTURE !VBAK
       VALUE(I_VBAP) LIKE !VBAP STRUCTURE !VBAP
       VALUE(I_LIPS) LIKE !LIPS STRUCTURE !LIPS OPTIONAL
       VALUE(I_LIKP) LIKE !LIKP STRUCTURE !LIKP OPTIONAL
       VALUE(I_VBRP) LIKE !VBRP STRUCTURE !VBRP OPTIONAL
       VALUE(I_VBRK) LIKE !VBRK STRUCTURE !VBRK OPTIONAL
    EXPORTING
       REFERENCE(E_VBAP) LIKE !VBAP STRUCTURE !VBAP
    EXCEPTIONS
       !OBJECT_UNKNOWN
       !ERROR_OCCURRED .