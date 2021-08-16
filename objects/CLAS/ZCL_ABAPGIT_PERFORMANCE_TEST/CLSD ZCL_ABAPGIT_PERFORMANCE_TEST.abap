class-pool .
*"* class pool for class ZCL_ABAPGIT_PERFORMANCE_TEST

*"* local type definitions
include ZCL_ABAPGIT_PERFORMANCE_TEST==ccdef.

*"* class ZCL_ABAPGIT_PERFORMANCE_TEST definition
*"* public declarations
  include ZCL_ABAPGIT_PERFORMANCE_TEST==cu.
*"* protected declarations
  include ZCL_ABAPGIT_PERFORMANCE_TEST==co.
*"* private declarations
  include ZCL_ABAPGIT_PERFORMANCE_TEST==ci.
endclass. "ZCL_ABAPGIT_PERFORMANCE_TEST definition

*"* macro definitions
include ZCL_ABAPGIT_PERFORMANCE_TEST==ccmac.
*"* local class implementation
include ZCL_ABAPGIT_PERFORMANCE_TEST==ccimp.

class ZCL_ABAPGIT_PERFORMANCE_TEST implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ABAPGIT_PERFORMANCE_TEST implementation
