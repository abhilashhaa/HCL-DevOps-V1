class-pool .
*"* class pool for class CX_NGC_API

*"* local type definitions
include CX_NGC_API====================ccdef.

*"* class CX_NGC_API definition
*"* public declarations
  include CX_NGC_API====================cu.
*"* protected declarations
  include CX_NGC_API====================co.
*"* private declarations
  include CX_NGC_API====================ci.
endclass. "CX_NGC_API definition

*"* macro definitions
include CX_NGC_API====================ccmac.
*"* local class implementation
include CX_NGC_API====================ccimp.

class CX_NGC_API implementation.
*"* method's implementations
  include methods.
endclass. "CX_NGC_API implementation
