"* use this source file for your ABAP unit test classes
CLASS ltc_ecatt_http DEFINITION INHERITING FROM tc_api_clfn_cls_integration FOR TESTING RISK LEVEL DANGEROUS DURATION MEDIUM.
  PROTECTED SECTION.
    METHODS get_http_bypass REDEFINITION.
ENDCLASS.

CLASS ltc_ecatt_http IMPLEMENTATION.

  METHOD get_http_bypass.
    rv_bypass_http = abap_false.
  ENDMETHOD.

ENDCLASS.

*CLASS ltc_ecatt_local DEFINITION INHERITING FROM tc_api_clfn_cls_integration FOR TESTING RISK LEVEL DANGEROUS DURATION MEDIUM.
*  PROTECTED SECTION.
*    METHODS get_http_bypass REDEFINITION.
*ENDCLASS.
*
*CLASS ltc_ecatt_local IMPLEMENTATION.
*
*  METHOD get_http_bypass.
*    rv_bypass_http = abap_true.
*  ENDMETHOD.
*
*ENDCLASS.