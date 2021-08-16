class-pool .
*"* class pool for class ZCL_ABAPGIT_PERSIST_SETTINGS

*"* local type definitions
include ZCL_ABAPGIT_PERSIST_SETTINGS==ccdef.

*"* class ZCL_ABAPGIT_PERSIST_SETTINGS definition
*"* public declarations
  include ZCL_ABAPGIT_PERSIST_SETTINGS==cu.
*"* protected declarations
  include ZCL_ABAPGIT_PERSIST_SETTINGS==co.
*"* private declarations
  include ZCL_ABAPGIT_PERSIST_SETTINGS==ci.
endclass. "ZCL_ABAPGIT_PERSIST_SETTINGS definition

*"* macro definitions
include ZCL_ABAPGIT_PERSIST_SETTINGS==ccmac.
*"* local class implementation
include ZCL_ABAPGIT_PERSIST_SETTINGS==ccimp.

*"* test class
include ZCL_ABAPGIT_PERSIST_SETTINGS==ccau.

class ZCL_ABAPGIT_PERSIST_SETTINGS implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ABAPGIT_PERSIST_SETTINGS implementation
