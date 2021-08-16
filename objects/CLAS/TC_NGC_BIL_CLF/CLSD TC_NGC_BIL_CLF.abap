class-pool .
*"* class pool for class TC_NGC_BIL_CLF

*"* local type definitions
include TC_NGC_BIL_CLF================ccdef.

*"* class TC_NGC_BIL_CLF definition
*"* public declarations
  include TC_NGC_BIL_CLF================cu.
*"* protected declarations
  include TC_NGC_BIL_CLF================co.
*"* private declarations
  include TC_NGC_BIL_CLF================ci.
endclass. "TC_NGC_BIL_CLF definition

*"* macro definitions
include TC_NGC_BIL_CLF================ccmac.
*"* local class implementation
include TC_NGC_BIL_CLF================ccimp.

*"* test class
include TC_NGC_BIL_CLF================ccau.

class TC_NGC_BIL_CLF implementation.
*"* method's implementations
  include methods.
endclass. "TC_NGC_BIL_CLF implementation
