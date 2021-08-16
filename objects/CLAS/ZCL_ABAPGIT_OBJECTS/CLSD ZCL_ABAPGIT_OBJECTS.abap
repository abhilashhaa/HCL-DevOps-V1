class-pool .
*"* class pool for class ZCL_ABAPGIT_OBJECTS

*"* local type definitions
include ZCL_ABAPGIT_OBJECTS===========ccdef.

*"* class ZCL_ABAPGIT_OBJECTS definition
*"* public declarations
  include ZCL_ABAPGIT_OBJECTS===========cu.
*"* protected declarations
  include ZCL_ABAPGIT_OBJECTS===========co.
*"* private declarations
  include ZCL_ABAPGIT_OBJECTS===========ci.
endclass. "ZCL_ABAPGIT_OBJECTS definition

*"* macro definitions
include ZCL_ABAPGIT_OBJECTS===========ccmac.
*"* local class implementation
include ZCL_ABAPGIT_OBJECTS===========ccimp.

*"* test class
include ZCL_ABAPGIT_OBJECTS===========ccau.

class ZCL_ABAPGIT_OBJECTS implementation.
*"* method's implementations
  include methods.
endclass. "ZCL_ABAPGIT_OBJECTS implementation
