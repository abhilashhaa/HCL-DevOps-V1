class-pool .
*"* class pool for class ZCL_ABAPGIT_CODE_INSPECTOR

*"* local type definitions
include ZCL_ABAPGIT_CODE_INSPECTOR====ccdef.

*"* class ZCL_ABAPGIT_CODE_INSPECTOR definition
*"* public declarations
  include ZCL_ABAPGIT_CODE_INSPECTOR====cu.
*"* protected declarations
  include ZCL_ABAPGIT_CODE_INSPECTOR====co.
*"* private declarations
  include ZCL_ABAPGIT_CODE_INSPECTOR====ci.
endclass. "ZCL_ABAPGIT_CODE_INSPECTOR definition

*"* macro definitions
include ZCL_ABAPGIT_CODE_INSPECTOR====ccmac.
*"* local class implementation
include ZCL_ABAPGIT_CODE_INSPECTOR====ccimp.

class ZCL_ABAPGIT_CODE_INSPECTOR implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ABAPGIT_CODE_INSPECTOR implementation
