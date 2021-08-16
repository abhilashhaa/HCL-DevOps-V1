class-pool .
*"* class pool for class ZCL_ABAPGIT_PERSISTENCE_REPO

*"* local type definitions
include ZCL_ABAPGIT_PERSISTENCE_REPO==ccdef.

*"* class ZCL_ABAPGIT_PERSISTENCE_REPO definition
*"* public declarations
  include ZCL_ABAPGIT_PERSISTENCE_REPO==cu.
*"* protected declarations
  include ZCL_ABAPGIT_PERSISTENCE_REPO==co.
*"* private declarations
  include ZCL_ABAPGIT_PERSISTENCE_REPO==ci.
endclass. "ZCL_ABAPGIT_PERSISTENCE_REPO definition

*"* macro definitions
include ZCL_ABAPGIT_PERSISTENCE_REPO==ccmac.
*"* local class implementation
include ZCL_ABAPGIT_PERSISTENCE_REPO==ccimp.

class ZCL_ABAPGIT_PERSISTENCE_REPO implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ABAPGIT_PERSISTENCE_REPO implementation
