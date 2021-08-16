class-pool .
*"* class pool for class ZCL_ABAPGIT_PERSISTENCE_USER

*"* local type definitions
include ZCL_ABAPGIT_PERSISTENCE_USER==ccdef.

*"* class ZCL_ABAPGIT_PERSISTENCE_USER definition
*"* public declarations
  include ZCL_ABAPGIT_PERSISTENCE_USER==cu.
*"* protected declarations
  include ZCL_ABAPGIT_PERSISTENCE_USER==co.
*"* private declarations
  include ZCL_ABAPGIT_PERSISTENCE_USER==ci.
endclass. "ZCL_ABAPGIT_PERSISTENCE_USER definition

*"* macro definitions
include ZCL_ABAPGIT_PERSISTENCE_USER==ccmac.
*"* local class implementation
include ZCL_ABAPGIT_PERSISTENCE_USER==ccimp.

class ZCL_ABAPGIT_PERSISTENCE_USER implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ABAPGIT_PERSISTENCE_USER implementation
