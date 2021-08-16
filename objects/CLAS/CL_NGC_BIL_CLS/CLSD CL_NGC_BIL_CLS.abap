class-pool .
*"* class pool for class CL_NGC_BIL_CLS

*"* local type definitions
include CL_NGC_BIL_CLS================ccdef.

*"* class CL_NGC_BIL_CLS definition
*"* public declarations
  include CL_NGC_BIL_CLS================cu.
*"* protected declarations
  include CL_NGC_BIL_CLS================co.
*"* private declarations
  include CL_NGC_BIL_CLS================ci.
endclass. "CL_NGC_BIL_CLS definition

*"* macro definitions
include CL_NGC_BIL_CLS================ccmac.
*"* local class implementation
include CL_NGC_BIL_CLS================ccimp.

*"* test class
include CL_NGC_BIL_CLS================ccau.

class CL_NGC_BIL_CLS implementation.
*"* method's implementations
  include methods.
endclass. "CL_NGC_BIL_CLS implementation
