class-pool .
*"* class pool for class CL_NGC_API

*"* local type definitions
include CL_NGC_API====================ccdef.

*"* class CL_NGC_API definition
*"* public declarations
  include CL_NGC_API====================cu.
*"* protected declarations
  include CL_NGC_API====================co.
*"* private declarations
  include CL_NGC_API====================ci.
endclass. "CL_NGC_API definition

*"* macro definitions
include CL_NGC_API====================ccmac.
*"* local class implementation
include CL_NGC_API====================ccimp.

*"* test class
include CL_NGC_API====================ccau.

class CL_NGC_API implementation.
*"* method's implementations
  include methods.
endclass. "CL_NGC_API implementation
