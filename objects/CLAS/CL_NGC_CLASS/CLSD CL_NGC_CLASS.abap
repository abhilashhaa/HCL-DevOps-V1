class-pool .
*"* class pool for class CL_NGC_CLASS

*"* local type definitions
include CL_NGC_CLASS==================ccdef.

*"* class CL_NGC_CLASS definition
*"* public declarations
  include CL_NGC_CLASS==================cu.
*"* protected declarations
  include CL_NGC_CLASS==================co.
*"* private declarations
  include CL_NGC_CLASS==================ci.
endclass. "CL_NGC_CLASS definition

*"* macro definitions
include CL_NGC_CLASS==================ccmac.
*"* local class implementation
include CL_NGC_CLASS==================ccimp.

*"* test class
include CL_NGC_CLASS==================ccau.

class CL_NGC_CLASS implementation.
*"* method's implementations
  include methods.
endclass. "CL_NGC_CLASS implementation
