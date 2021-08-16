*"* use this source file for your ABAP unit test classes

CLASS lcl_integration_test_http DEFINITION
  INHERITING FROM tc_api_clfn_chr
  FOR TESTING
  RISK LEVEL DANGEROUS
  DURATION MEDIUM.
  PROTECTED SECTION.
    METHODS get_http_bypass REDEFINITION.
ENDCLASS.

CLASS lcl_integration_test_http IMPLEMENTATION.

  METHOD get_http_bypass.
    rv_bypass_http = abap_false.
  ENDMETHOD.

ENDCLASS.


*CLASS lcl_integration_test_local DEFINITION
*  INHERITING FROM tc_api_clfn_chr
*  FOR TESTING
*  DURATION MEDIUM
*  RISK LEVEL DANGEROUS.
*
*  PROTECTED SECTION.
*    METHODS:
*      get_http_bypass REDEFINITION.
*
*ENDCLASS.
*
*CLASS lcl_integration_test_local IMPLEMENTATION.
*  METHOD get_http_bypass.
*    rv_bypass_http = abap_true.
*  ENDMETHOD.
*
*ENDCLASS.