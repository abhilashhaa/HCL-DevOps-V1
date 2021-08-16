class-pool .
*"* class pool for class TC_NGC_BIL_CLS

*"* local type definitions
include TC_NGC_BIL_CLS================ccdef.

*"* class TC_NGC_BIL_CLS definition
*"* public declarations
  include TC_NGC_BIL_CLS================cu.
*"* protected declarations
  include TC_NGC_BIL_CLS================co.
*"* private declarations
  include TC_NGC_BIL_CLS================ci.
endclass. "TC_NGC_BIL_CLS definition

*"* macro definitions
include TC_NGC_BIL_CLS================ccmac.
*"* local class implementation
include TC_NGC_BIL_CLS================ccimp.

*"* test class
include TC_NGC_BIL_CLS================ccau.

class TC_NGC_BIL_CLS implementation.
*"* method's implementations
  include methods.
endclass. "TC_NGC_BIL_CLS implementation
