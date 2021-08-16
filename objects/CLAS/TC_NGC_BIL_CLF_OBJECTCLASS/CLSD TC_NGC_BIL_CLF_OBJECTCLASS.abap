class-pool .
*"* class pool for class TC_NGC_BIL_CLF_OBJECTCLASS

*"* local type definitions
include TC_NGC_BIL_CLF_OBJECTCLASS====ccdef.

*"* class TC_NGC_BIL_CLF_OBJECTCLASS definition
*"* public declarations
  include TC_NGC_BIL_CLF_OBJECTCLASS====cu.
*"* protected declarations
  include TC_NGC_BIL_CLF_OBJECTCLASS====co.
*"* private declarations
  include TC_NGC_BIL_CLF_OBJECTCLASS====ci.
endclass. "TC_NGC_BIL_CLF_OBJECTCLASS definition

*"* macro definitions
include TC_NGC_BIL_CLF_OBJECTCLASS====ccmac.
*"* local class implementation
include TC_NGC_BIL_CLF_OBJECTCLASS====ccimp.

*"* test class
include TC_NGC_BIL_CLF_OBJECTCLASS====ccau.

class TC_NGC_BIL_CLF_OBJECTCLASS implementation.
*"* method's implementations
  include methods.
endclass. "TC_NGC_BIL_CLF_OBJECTCLASS implementation
